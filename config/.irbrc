# frozen_string_literal: true
autoload :Base64, 'base64'
autoload :CGI, 'cgi'
autoload :CSV, 'csv'
autoload :Digest, 'digest'
autoload :ERB, 'erb'
autoload :FileUtils, 'fileutils'
autoload :JSON, 'json'
autoload :Pathname, 'pathname'
autoload :Psych, 'psych'
autoload :Ripper, 'ripper'
autoload :SecureRandom, 'securerandom'
autoload :Shellwords, 'shellwords'
autoload :StringIO, 'stringio'
autoload :URI, 'uri/generic' # `autoload :URI, 'uri'` breaks Rails
autoload :YAML, 'yaml'
autoload :Zlib, 'zlib'

IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:USE_PAGER] = false
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

begin
  require 'irb/cmd/debug'
rescue LoadError
else
  module IRB::ExtendCommand
    class Up < DebugCommand
      def execute(*args)
        super(pre_cmds: ['up', *args].join(' '))
      end
    end
  end
  IRB::ExtendCommandBundle.def_extend_command(:irb_up, :Up, 'cmd/nop', [:up, IRB::ExtendCommandBundle::NO_OVERRIDE])
end
