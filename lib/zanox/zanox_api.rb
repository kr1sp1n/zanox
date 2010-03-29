require 'base64'
# require 'hmac-sha1'
require 'digest/md5'

module Zanox
  module API
    VERSIONS = {
      :deprecated => ['2009-07-01'],
      :latest => '2010-02-01'
    }
    def API.included(mod)
      puts "#{self} included in #{mod}"
    end
    def is_deprecated?(version)
       VERSIONS[:deprecated].include?(version)
    end
    def versions
      VERSIONS
    end
    def nonce
      mt = Time.new.usec
      rand = rand()
      Digest::MD5.hexdigest((mt + rand).to_s)
    end
    def timestamp
      Time.new.gmtime.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end
    def create_signature(secret_key, string2sign)
      # signature = Base64.encode64(HMAC::SHA1.new(secret_key).update(string2sign).digest)[0..-2]
      "testsignature"
    end
    module_function :versions
    module_function :is_deprecated?
  end
end