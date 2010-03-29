module Zanox
  class Product
    attr_accessor :id
    attr_accessor :name
    attr_accessor :description
    attr_accessor :price
    
    def initialize(options={})
      options.each do | key, value |
        if self.respond_to?(key)
          m = self.method(key.to_s+"=")
          m.call(value)
        end
      end
    end
    
    def find(filter=nil)
      case filter.class.to_s
        when "Fixnum" then return "it's an id!"
        else return "yo!"
      end
    end
    
    def update
      "update " + self.to_s
    end
    
    def delete(id)
      "delete " + self.to_s
    end
    
  end
end
    