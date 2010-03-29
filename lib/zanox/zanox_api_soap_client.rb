require 'zanox_api'
require 'zanox_api_soap'

module Zanox
  module API
    module SOAP
      class Client
        attr_accessor :connection
        attr_accessor :api_version
        attr_accessor :response_format

        def initialize(options={})
          @api_version = options[:api_version] || Zanox::API.versions[:latest]
        end

        def login(user, password)
          @user = user
          @password = password
        end

        def to_s
          @user + ", " + @password
        end
      end
    end
  end
end

c = Zanox::API::SOAP::Client.new