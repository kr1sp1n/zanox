require 'rubygems'

module Zanox
  module API
    require 'soap/wsdlDriver'
    require 'base64'
    require 'hmac-sha1'
    require 'digest/md5'
    
    class AuthError < ArgumentError; end
    
    attr_accessor :connect_id
    attr_accessor :secret_key
    attr_accessor :wsdl
    
    def self.request(method, options)
      puts method + " " + options.inspect if $DEBUG
      
      options.merge!(:connectId=>Zanox::API.connect_id)
      
      raise AuthError, "Missing connect id. Try calling Zanox::API.authenticate('your connect id', 'your secret key') before your requests", caller[caller.length - 1] if !!options[:connect_id]
      
      wsdl = 'http://api.zanox.com/wsdl/2009-07-01/' unless !!wsdl
      $driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver unless !!$driver
      $driver.wiredump_dev = STDOUT if $DEBUG
      $driver.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE if $DEBUG
      $driver.method(method.to_sym).call(options)
    end
    
    def self.generate_nonce
      mt = Time.new.usec
      rand = rand()
      Digest::MD5.hexdigest((mt + rand).to_s)
    end
    
    def self.get_timestamp
      Time.new.gmtime.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end
    
    def self.create_signature(secret_key, string2sign)
      signature = Base64.encode64(HMAC::SHA1.new(secret_key).update(string2sign).digest)[0..-2]
    end
    
    def self.authenticate(connect_id, secret_key)
      #todo: real session request with connect flow
      @connect_id = connect_id
      @secret_key = secret_key
      true
    end
    
    self.instance_methods.each do |method|
       module_function method.to_sym
    end
  end
  
  module Item
    attr_accessor :id

    def new(item=nil)
      item.extend(self)
      item.id= item.xmlattr_id 
      return item
    end
    
    def find_every(options)
      items = []
      class_name = self.name.split('::').last  
      api_method = 'get'+self.pluralize
      timestamp = Zanox::API.get_timestamp
      nonce = Zanox::API.generate_nonce
      
      signature = Zanox::API.create_signature(Zanox::API.secret_key, "publisherservice"+api_method.downcase + timestamp + nonce)
      options.merge!(:timestamp=>timestamp, :nonce=>nonce, :signature=>signature)
      
      response = Zanox::API.request(api_method, options)
      
      m1_name = (class_name.downcase+'Items').to_sym
      m2_name = (class_name.downcase+'Item').to_sym
                  
      if(response.respond_to?(m1_name))
        items_object = response.method(m1_name).call
        if(items_object.respond_to?(m2_name))
          item_object = items_object.method(m2_name).call
          if(item_object.is_a?(Array))
            item_list = item_object
          else
            item_list = [item_object]
          end
          [*item_object].each do |item|
            items.push self.new(item)
          end
        end
      end
    end
    
    def find_other(args, options)
      ids = []
      queries = []
      items = []
      args.each do |arg|
        self.is_key?(arg) ? ids.push(arg) : queries.push(arg)
      end

      puts "found ids: "+ids.to_s if $DEBUG
      puts "found query strings: "+queries.to_s if $DEBUG

      class_name = self.name.split('::').last
      api_method = ''
      timestamp = Zanox::API.get_timestamp
      nonce = Zanox::API.generate_nonce

      if(ids.size>0)
        api_method = 'get'+class_name.capitalize
        signature = Zanox::API.create_signature(Zanox::API.secret_key, "publisherservice"+api_method.downcase + timestamp + nonce)
        options.merge!(:timestamp=>timestamp, :nonce=>nonce, :signature=>signature)

        ids.each do |id|
          options.merge!(self.key_symbol=>id)
          response = Zanox::API.request(api_method, options)
          item = self.new(response.method((class_name.downcase+'Item').to_sym).call)
          items.push item
        end
      end

      if(queries.size>0)
        api_method = 'search'+self.pluralize

        queries.each do |query|
          options.merge!(:query=>query)
          response = Zanox::API.request(api_method, options)
          m1_name = (class_name.downcase+'Items').to_sym
          m2_name = (class_name.downcase+'Item').to_sym

          if(response.respond_to?(m1_name))
            items_object = response.method(m1_name).call
            if(items_object.respond_to?(m2_name))
              item_object = items_object.method(m2_name).call
              if(item_object.is_a?(Array))
                item_list = item_object
              else
                item_list = [item_object]
              end
              [*item_object].each do |item|
                items.push self.new(item)
              end
            end
          end
        end
      end
      
      items
    end
    
    def find(*args)
      
      options = args.last.is_a?(Hash) ? args.pop : {}
      
      puts "Arguments: " + args.inspect if $DEBUG
      puts "Options: " + options.inspect if $DEBUG
      
      case args.first
        when :all then find_every(options)
        when nil  then find_every(options)
        else           find_other(args, options)
      end
      
    end
  end
  
  module Program
    include Item
    extend  Item
    
    def self.key_symbol
      :programId
    end
    
    def self.pluralize
      "Programs"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]{3,6}/] ? true : false
    end
  end
  
  module Admedium
    include Item
    extend  Item
    
    def self.key_symbol
      :admediumId
    end
    
    def self.pluralize
      "Admedia"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]{3,6}/] ? true : false
    end
  end
  
  module Product
    include Item
    extend  Item
    
    def self.key_symbol
      :zupId
    end
    
    def self.pluralize
      "Products"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9A-Fa-f]{32}/] ? true : false
    end
  end
  
  module Adspace
    include Item
    extend Item
    
    def self.key_symbol
      :adspaceId
    end
    
    def self.pluralize
      "Adspaces"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]/] ? true : false
    end
  end
  
  module Sale
    include Item
    extend  Item
    
    def self.key_symbol
      :saleId
    end
    
    def self.pluralize
      "Sales"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]/] ? true : false
    end
  end
  
  module Lead
    include Item
    extend  Item
    
    def self.key_symbol
      :leadId
    end
    
    def self.pluralize
      "Leads"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]/] ? true : false
    end
  end
  
end
