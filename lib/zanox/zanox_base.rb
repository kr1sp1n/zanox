require 'hmac-sha1'
require 'base64' 

module Zanox
  
  class ZanoxBase
    
    attr_accessor :timestamp
    attr_reader :application_id, :last_error_msg
    attr_writer :version
    
    def initialize(version = false)
      @version = version
      @application_id = ''
      @shared_key = ''
      @timestamp = false
      @version = false
      @api_security = false
      @last_error_msg = false
    end
    
    def set_message_credentials(application_id, shared_key)
      @application_id = application_id
      @shared_key     = shared_key
    end

    protected

    def get_hmac_signature(mesgparams)
      hmac = Base64.encode64(HMAC::SHA1.digest(@shared_key, mesgparams)).chomp
      hmac
    end

    def enable_api_security
      @api_security = true
    end

    def disable_api_security
      @api_security = false
    end

    def get_timestamp

    end
    
  end
  
end
