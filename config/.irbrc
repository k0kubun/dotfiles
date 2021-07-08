# frozen_string_literal: true
autoload :Base64, 'base64'
autoload :CGI, 'cgi'
autoload :CSV, 'csv'
autoload :Digest, 'digest'
autoload :ERB, 'erb'
autoload :FileUtils, 'fileutils'
autoload :JSON, 'json'
autoload :Psych, 'psych'
autoload :Ripper, 'ripper'
autoload :SecureRandom, 'securerandom'
autoload :Shellwords, 'shellwords'
autoload :StringIO, 'stringio'
autoload :URI, 'uri'
autoload :YAML, 'yaml'
autoload :Zlib, 'zlib'

IRB::METHOD_AUTOLOAD = Hash.new({
  to_json: 'json',
  to_yaml: 'yaml',
}).merge({
  Time => { parse: 'time' },
})
Kernel.module_eval do
  def method_missing(name, *args, &block)
    if lib = IRB::METHOD_AUTOLOAD[self][name]
      require lib
      return self.public_send(name, *args, &block)
    end
    super
  end
end

#IRB.conf[:USE_MULTILINE] = false
IRB.conf[:SAVE_HISTORY] = 1000
#IRB.conf[:INSPECT_MODE] = :inspect
if defined?(IRB::Color) # just for consistency
  clear = "\e[0m"
  bold = "\e[1m"
  green = "\e[32m"
  blue = "\e[34m"
  cyan = "\e[36m"
  IRB.conf[:PROMPT][:DEFAULT] = {
    PROMPT_I: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%02n#{clear}:%i]> ",
    PROMPT_N: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%02n#{clear}:%i]> ",
    PROMPT_S: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%02n#{clear}:%i]%l ",
    PROMPT_C: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%02n#{clear}:%i]* ",
    RETURN: "=> %s\n",
  }
end

begin
  require 'irb/cmd/whereami'
rescue LoadError
  require 'irb/cmd/nop'
  module IRB
    module ExtendCommand
      class Whereami < Nop
        def execute(*)
          code = irb_context.workspace.code_around_binding
          if code
            puts code
          else
            puts "The current context doesn't have code."
          end
        end
      end
    end
  end
  IRB::ExtendCommandBundle.def_extend_command(:irb_whereami, :Whereami, 'irb/cmd/nop', [:whereami, IRB::ExtendCommandBundle::NO_OVERRIDE])
end

if defined?(IRB::Color) # used by IRB::ExtendCommand::Ls
  begin
    require 'irb/cmd/ls'
  rescue LoadError
    require 'irb/cmd/nop'
    module IRB
      module ExtendCommand
        class Ls < Nop
          def execute(*arg, grep: nil)
            o = Output.new(grep: grep)

            obj    = arg.empty? ? irb_context.workspace.main : arg.first
            locals = arg.empty? ? irb_context.workspace.binding.local_variables : []
            klass  = (obj.class == Class || obj.class == Module ? obj : obj.class)

            o.dump("constants", obj.constants) if obj.respond_to?(:constants)
            dump_methods(o, klass, obj)
            o.dump("instance variables", obj.instance_variables)
            o.dump("class variables", klass.class_variables)
            o.dump("locals", locals)
          end

          def dump_methods(o, klass, obj)
            singleton_class = begin obj.singleton_class; rescue TypeError; nil end
            maps = class_method_map((singleton_class || klass).ancestors)
            maps.each do |mod, methods|
              name = mod == singleton_class ? "#{klass}.methods" : "#{mod}#methods"
              o.dump(name, methods)
            end
          end

          def class_method_map(classes)
            dumped = Set.new
            classes.reject { |mod| mod >= Object }.map do |mod|
              methods = mod.public_instance_methods(false).select { |m| dumped.add?(m) }
              [mod, methods]
            end.reverse
          end

          class Output
            MARGIN = "  "

            def initialize(grep: nil)
              @grep = grep
              @line_width = screen_width - MARGIN.length # right padding
            end

            def dump(name, strs)
              strs = strs.grep(@grep) if @grep
              strs = strs.sort
              return if strs.empty?

              # Attempt a single line
              print "#{Color.colorize(name, [:BOLD, :BLUE])}: "
              if fits_on_line?(strs, cols: strs.size, offset: "#{name}: ".length)
                puts strs.join(MARGIN)
                return
              end
              puts

              # Dump with the largest # of columns that fits on a line
              cols = strs.size
              until fits_on_line?(strs, cols: cols, offset: MARGIN.length) || cols == 1
                cols -= 1
              end
              widths = col_widths(strs, cols: cols)
              strs.each_slice(cols) do |ss|
                puts ss.map.with_index { |s, i| "#{MARGIN}%-#{widths[i]}s" % s }.join
              end
            end

            private

            def fits_on_line?(strs, cols:, offset: 0)
              width = col_widths(strs, cols: cols).sum + MARGIN.length * (cols - 1)
              width <= @line_width - offset
            end

            def col_widths(strs, cols:)
              cols.times.map do |col|
                (col...strs.size).step(cols).map do |i|
                  strs[i].length
                end.max
              end
            end

            def screen_width
              Reline.get_screen_size.last
            rescue Errno::EINVAL # in `winsize': Invalid argument - <STDIN>
              80
            end
          end
          private_constant :Output
        end
      end
    end
    IRB::ExtendCommandBundle.def_extend_command(:irb_ls, :Ls, 'irb/cmd/nop', [:ls, IRB::ExtendCommandBundle::NO_OVERRIDE])
  end

  begin
    require 'irb/cmd/show_source'
  rescue LoadError
    require 'irb/cmd/nop'
    module IRB
      module ExtendCommand
        class ShowSource < Nop
          def execute(str = nil)
            unless str.is_a?(String)
              puts "Error: Expected a string but got #{str.inspect}"
              return
            end
            source = find_source(str)
            if source && File.exist?(source.file)
              show_source(source)
            else
              puts "Error: Couldn't locate a definition for #{str}"
            end
            nil
          end

          private

          # @param [IRB::ExtendCommand::ShowSource::Source] source
          def show_source(source)
            puts
            puts "#{bold("From")}: #{source.file}:#{source.first_line}"
            puts
            code = IRB::Color.colorize_code(File.read(source.file))
            puts code.lines[(source.first_line - 1)...source.last_line].join
            puts
          end

          def find_source(str)
            case str
            when /\A[A-Z]\w*(::[A-Z]\w*)*\z/ # Const::Name
              eval(str, irb_context.workspace.binding) # trigger autoload
              base = irb_context.workspace.binding.receiver.yield_self { |r| r.is_a?(Module) ? r : Object }
              file, line = base.const_source_location(str) if base.respond_to?(:const_source_location) # Ruby 2.7+
            when /\A(?<owner>[A-Z]\w*(::[A-Z]\w*)*)#(?<method>[^ :.]+)\z/ # Class#method
              owner = eval(Regexp.last_match[:owner], irb_context.workspace.binding)
              method = Regexp.last_match[:method]
              if owner.respond_to?(:instance_method) && owner.instance_methods.include?(method.to_sym)
                file, line = owner.instance_method(method).source_location
              end
            when /\A((?<receiver>.+)(\.|::))?(?<method>[^ :.]+)\z/ # method, receiver.method, receiver::method
              receiver = eval(Regexp.last_match[:receiver] || 'self', irb_context.workspace.binding)
              method = Regexp.last_match[:method]
              file, line = receiver.method(method).source_location if receiver.respond_to?(method)
            end
            if file && line
              Source.new(file: file, first_line: line, last_line: find_end(file, line))
            end
          end

          def find_end(file, first_line)
            return first_line unless File.exist?(file)
            lex = RubyLex.new
            code = +""
            File.read(file).lines[(first_line - 1)..-1].each_with_index do |line, i|
              _ltype, _indent, continue, code_block_open = lex.check_state(code << line)
              if !continue && !code_block_open
                return first_line + i
              end
            end
            first_line
          end

          def bold(str)
            Color.colorize(str, [:BOLD])
          end

          Source = Struct.new(
            :file,       # @param [String] - file name
            :first_line, # @param [String] - first line
            :last_line,  # @param [String] - last line
            keyword_init: true,
          )
          private_constant :Source
        end
      end
    end
    IRB::ExtendCommandBundle.def_extend_command(:irb_show_source, :ShowSource, 'irb/cmd/nop', [:show_source, IRB::ExtendCommandBundle::NO_OVERRIDE])
  end

  # Convert @, $, and -G/--grep
  IRB::Context.prepend(Module.new{
    kwargs = RUBY_VERSION >= '2.7.0' ? ', **' : ''
    line = __LINE__; eval %q{
      def evaluate(line, *__ARGS__)
        case line
        when "@\n"
          line.replace("whereami\n")
        when /\A\$ /
          line.replace("show_source #{line.sub(/\A\$ /, '').strip.dump}\n")
        when /(-G|--grep)/
          if line.sub!(/\A\s*ls\s/, '')
            grep = nil
            line.gsub!(/(-G|--grep)\s+([^\s]+)/) { grep = $2; '' }
            line = line.tap(&:chomp!).empty? ? '' : "#{line},"
            line.replace("IRB::ExtendCommand::Ls.new(irb_context).execute(#{line} grep: /#{grep}/)")
          end
        end
        super
      end
    }.sub(/__ARGS__/, kwargs), nil, __FILE__, line
  })

  IRB::ReidlineInputMethod.prepend(Module.new{
    def check_termination(&block)
      super do |code|
        next true if code == "@\n" || code.start_with?('ls ')
        block.call(code)
      end
    end
  })

  Reline.singleton_class.prepend(Module.new{
    def output_modifier_proc=(block)
      super(
        proc do |output, complete:|
          if output.start_with?('$')
            "$#{block.call(output[1..-1], complete: complete)}"
          elsif output.include?('-G')
            left, right = output.split('-G', 2)
            "#{block.call(left, complete: complete)}-G#{right}"
          elsif output == "@\n"
            output
          else
            block.call(output, complete: complete)
          end
        end
      )
    end
  })
end
