require 'zanox_api'
require 'zanox_api_soap'

module Zanox
  module API
    module SOAP
      def connect(filter)
      end
      
      class Connection
        attr_accessor :rpc_driver
        def initialize(wsdl)
          @rpc_driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
          @rpc_driver.wiredump_dev = STDERR
          @rpc_driver.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE
        end
      end
    end
  end
end