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

# evaluate's signature is different in old versions
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7.0')
  def IRB.ls(obj, locals, grep)
    dump = proc do |name, strs|
      strs = strs.grep(/#{grep}/) if grep
      strs = strs.sort
      next if strs.empty?

      print "\e[1m\e[34m#{name}\e[0m: "
      if strs.size > 7
        len = [strs.map(&:length).max, 16].min
        puts; strs.each_slice(7) { |ss| puts "  #{ss.map { |s| "%-#{len}s" % s }.join('  ')}" }
      else
        puts strs.join('  ')
      end
    end

    dump.call('constants', obj.constants) if obj.respond_to?(:constants)

    klass = (obj.class == Class || obj.class == Module ? obj : obj.class)
    dump.call("#{klass}.methods", obj.singleton_methods(false))
    dump.call("#{klass}#methods", klass.public_instance_methods(false))

    dump.call('instance variables', obj.instance_variables)
    dump.call('class variables', klass.class_variables)
    dump.call('locals', locals)
  end

  IRB::Context.prepend(Module.new{
    def evaluate(line, *, **)
      if line.sub!(/\A\s*ls\s/, '')
        grep = nil
        line.gsub!(/(-G|--grep)\s+([^\s]+)/) { grep = $2; '' }
        obj    = (is_self = line.strip.empty?) ? 'self' : line.chomp
        locals = is_self ? 'local_variables' : '[]'
        line.replace("IRB.ls(#{obj}, #{locals}, #{grep.inspect}); _ = nil") # make `assignment_expression?(line)` true by replace
      end
      super
    end
  })
end
