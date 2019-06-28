# frozen_string_literal: true
require 'time' # Time.parse
autoload :Base64, 'base64'
autoload :CSV, 'csv'
autoload :Digest, 'digest'
autoload :ERB, 'erb'
autoload :JSON, 'json'
autoload :Psych, 'psych'
autoload :Ripper, 'ripper'
autoload :SecureRandom, 'securerandom'
autoload :URI, 'uri'
autoload :YAML, 'yaml'

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
  IRB.conf[:SAVE_HISTORY] = 1000
end
