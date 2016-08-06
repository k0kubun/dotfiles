require 'irb/completion'

module IRB
  def self.dbg(binding)
    require 'irb/ext/multi-irb' rescue NoMethodError
    IRB.irb(nil, binding)
    puts 'a'
  end
end
