module Zanox
  
  class ZanoxJson < ZanoxXml
    
    def initialize(version = false)
      @version = version
      @rest_action = 'GET'
      @url = 'http://api.zanox.com/json'
      @content_type = 'application/json'
      @raw_data_disabled = true
    end
    
#    def serialize#TODO
#      
#    end
    
  end
  
end