Pry.editor = 'vim'

Pry.config.prompt = [
  proc { |target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[\e[34m#{pry.input_array.size}\e[0m] \e[36m\e[1m#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}\e[0m (\e[32m\e[1m#{Pry.view_clip(target_self)}\e[0m)#{nested}> "
  },
  proc { |target_self, nest_level, pry|
    nested = (nest_level.zero?) ?  '' : ":#{nest_level}"
    "[\e[34m#{pry.input_array.size}\e[0m] \e[36m\e[1m#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}\e[0m (\e[32m\e[1m#{Pry.view_clip(target_self)}\e[0m)#{nested}* "
  }
]

if defined?(PryByebug)
  aliases = {
    'n' => 'next',
    's' => 'step',
    'f' => 'finish',
    #'c' => 'continue',
  }

  require 'pry-byebug/version'
  if Gem::Version.new(PryByebug::VERSION) >= Gem::Version.new('3.4.0')
    aliases.merge!('bt' => 'backtrace')
  end

  aliases.each do |from, to|
    Pry::Commands.alias_command(from, to)
  end
end

# def ppp(code)
#   puts Pry.Code(code).highlighted
# end

autoload :URI, 'uri'
autoload :Base64, 'base64'
autoload :SecureRandom, 'securerandom'
autoload :JSON, 'json'
autoload :YAML, 'yaml'
autoload :ERB, 'erb'
