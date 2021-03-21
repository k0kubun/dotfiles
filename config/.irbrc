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
            o.dump("#{klass}.methods", obj.singleton_methods(false))
            o.dump("#{klass}#methods", klass.public_instance_methods(false))
            o.dump("instance variables", obj.instance_variables)
            o.dump("class variables", klass.class_variables)
            o.dump("locals", locals)
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
    IRB::ExtendCommandBundle.def_extend_command(:irb_ls, :Ls, "irb/cmd/nop", [:ls, IRB::ExtendCommandBundle::NO_OVERRIDE])
  end

  # Convert -G/--grep to keyword args
  IRB::Context.prepend(Module.new{
    kwargs = Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7.0') ? ', **' : ''
    line = __LINE__; eval %q{
      def evaluate(line, *__ARGS__)
        if line.sub!(/\A\s*ls\s/, '')
          grep = nil
          line.gsub!(/(-G|--grep)\s+([^\s]+)/) { grep = $2; '' }
          line = line.tap(&:chomp!).empty? ? 'self' : line
          line.replace("IRB::ExtendCommand::Ls.new(irb_context).execute(#{line}, grep: /#{grep}/)")
        end
        super
      end
    }.sub(/__ARGS__/, kwargs), nil, __FILE__, line
  })
end
