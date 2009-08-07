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

    def set_connect_credentials(public_key)
       @public_key = public_key
    end

    protected

    def get_hmac_signature(mesgparams, key = nil)
       key ||= @shared_key
       key = '3a24b0acdd0a45+990dc2Ae514dfe0/c791fca4A'

       digest = OpenSSL::Digest::Digest.new('sha1')
       hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, key, mesgparams)).chomp.gsub(/\n/,'')
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

    def generate_nonce
       (Base64.encode64(((rand() * 100000000).to_i.to_s + Time.now.to_s + "-somerandfasdf-"  )).to_s)[0..19]
    end

  end

end
