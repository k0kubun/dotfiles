# frozen_string_literal: true
require 'time' # Time.parse
autoload :URI, 'uri'
autoload :Base64, 'base64'
autoload :SecureRandom, 'securerandom'
autoload :JSON, 'json'
autoload :YAML, 'yaml'
autoload :Psych, 'psych'
autoload :ERB, 'erb'

IRB::Irb.prepend(Module.new {
  def prompt(prompt, *rest)
    clear = "\e[0m"
    bold = "\e[1m"
    green = "\e[32m"
    blue = "\e[34m"
    cyan = "\e[36m"
    super(prompt.sub(/\A%N\(%m\):%03n:%i/, "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%n#{clear}:%i]"), *rest)
  end
})
