$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'

require 'zanox/zanox_base'
require 'zanox/zanox_xml'
require 'zanox/zanox_json'
require 'zanox/zanox_soap'

# Module to encapsule the Zanox API.
module Zanox

  class Factory
    
    def Factory.get_interface(interface, version = false)
      case interface
        when 'xml'
          obj = ZanoxXml.new(version)
        when 'json'
          obj = ZanoxJson.new(version)
        when 'soap'
          obj =  ZanoxSoap.new
        else
          raise 'No such Interface!'
      end

      return obj
    end
    
  end
  
end
