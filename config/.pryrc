Pry.editor = 'vim'

Pry.config.commands.alias_command 'vi', 'edit'

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
  {
    'n' => 'next',
    's' => 'step',
    'f' => 'finish',
    'c' => 'continue',
  }.each do |from, to|
    Pry::Commands.alias_command(from, to)
  end
end

def ppp(code)
  puts Pry.Code(code).highlighted
end

# require 'active_support'
# require 'active_support/core_ext'
