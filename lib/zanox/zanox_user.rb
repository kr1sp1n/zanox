module Zanox
  module User
    def User.included(mod)
      puts "#{self} included in #{mod}"
    end
    def connect
      puts 'connect'
    end
  end
end