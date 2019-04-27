# frozen_string_literal: true
require 'time' # Time.parse
autoload :URI, 'uri'
autoload :Base64, 'base64'
autoload :SecureRandom, 'securerandom'
autoload :JSON, 'json'
autoload :YAML, 'yaml'
autoload :Psych, 'psych'
autoload :ERB, 'erb'
autoload :Digest, 'digest'

if defined?(IRB::Color) # just for consistency
  clear = "\e[0m"
  bold = "\e[1m"
  green = "\e[32m"
  blue = "\e[34m"
  cyan = "\e[36m"
  IRB.conf[:PROMPT][:DEFAULT] = {
    PROMPT_I: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%n#{clear}:%i]> ",
    PROMPT_N: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%n#{clear}:%i]> ",
    PROMPT_S: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%n#{clear}:%i%l] ",
    PROMPT_C: "#{cyan}#{bold}%N#{clear}(#{green}#{bold}%m#{clear})[#{blue}%n#{clear}:%i]* ",
    RETURN: "=> %s\n",
  }
  IRB.conf[:SAVE_HISTORY] = 1000
end
