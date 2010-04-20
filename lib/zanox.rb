# Dir.glob(File.join(File.dirname(__FILE__), 'zanox/*.rb')).each { |f| require f }
require 'rubygems'

module Zanox
  module API
    require 'soap/wsdlDriver'
    require 'base64'
    require 'hmac-sha1'
    require 'digest/md5'
    
    attr_accessor :session
    attr_accessor :services
    
    attr_accessor :connect_id
    attr_accessor :secret_key
    
    def self.request(method, options)
      # Mock:
      # wsdl = 'http://krispin.local:8080/?WSDL'
      # Live:
      wsdl = 'http://api.zanox.com/wsdl/2009-07-01/'
      $api = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
      $api.wiredump_dev = STDERR
      #$api.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE
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
      #todo: real session request
      @connect_id = connect_id
      @secret_key = secret_key
      true
    end
    
    self.instance_methods.each do |method|
       # puts method
       module_function method.to_sym
    end
  end
  module Item
    attr_writer :restrictions
    
    def restrictions
      @restrictions ||= Hash.new
    end
    
    # SOAP::Mapping::Object extends with Zanox::Product specific methods, like delete etc.
    def new(item=nil)
      item.extend(self)
      item.id= item.xmlattr_id 
      return item
    end
    
    def restrict(*methods)
      methods.each do |m|
        self.restrictions[m] = true
      end
    end
    
    def create
      #create new Item and save it
    end
    
    def update(id, attributes)
    end
    
    def delete
    end
    
    def find_every(options)
      queries = []
      items = []
      options.each do |option|
        unless self.is_key?(option)
          queries.push(arg)
        end
      end
      
    end
    
    def find_from_ids(ids, options)
    end
    
    def find(*args)
      # case args.first
      #   #when :first then find_initial(options)
      #   #when :last  then find_last(options)
      #   when :all   then find_every(options)
      #   else             find_from_ids(args, options)
      # end
      
      ids = []
      queries = []
      items = []
                  
      options = args.last.is_a?(Hash) ? args.pop : {}
      options.merge!(:connectId=>Zanox::API.connect_id)
      puts options
      
      args.each do |arg|
        self.is_key?(arg) ? ids.push(arg) : queries.push(arg)
      end
      
      puts
      puts "found ids: "+ids.size.to_s
      puts ids
      puts "found query strings: "+queries.size.to_s
      puts queries
      puts
                  
      require 'soap/wsdlDriver'
                  
      # Mock:
      # wsdl = 'http://krispin.local:8080/?WSDL'
      # Live:
      wsdl = 'http://api.zanox.com/wsdl/2009-07-01/'
      $api = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
      $api.wiredump_dev = STDERR
      #$api.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE
                  
      class_name = self.name.split('::').last
      api_method = ''
      timestamp = Zanox::API.get_timestamp
      nonce = Zanox::API.generate_nonce
                  
      if(ids.size>0)
        api_method = 'get'+class_name.capitalize
        get_item = $api.method(api_method.to_sym)
            
        if(self.restrictions[:read])
          signature = Zanox::API.create_signature(Zanox::API.secret_key, "publisherservice"+api_method.downcase + timestamp + nonce)
          options.merge!(:timestamp=>timestamp, :nonce=>nonce, :signature=>signature)
        end
            
        ids.each do |id|
          options.merge!(self.key_symbol=>id)
          item = self.new(get_item.call(options).method((class_name.downcase+'Item').to_sym).call)
          items.push item
        end
      end
                  
      if(queries.size>0)
        api_method = 'search'+self.pluralize
        search_item = $api.method(api_method.to_sym)
            
        queries.each do |query|
          options.merge!(:query=>query)
          response = search_item.call(options)
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
                  
      if(queries.size==0 && ids.size==0 && options.size>0)
        api_method = 'get'+self.pluralize
        get_items = $api.method(api_method.to_sym)
                    
        if(self.restrictions[:read])
          signature = Zanox::API.create_signature(Zanox::API.secret_key, "publisherservice"+api_method.downcase + timestamp + nonce)
          options.merge!(:timestamp=>timestamp, :nonce=>nonce, :signature=>signature)
        end
                    
        response = get_items.call(options)
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
            
      puts api_method
      puts options.inspect
            
      #self is the class that calls module method :find
      items
    end
    
    def exists?(id_or_conditions)
    end
    
    # self.instance_methods.each do |method|
    #   # puts method
    #   module_function method.to_sym
    # end
    
  end
  
  module Program
    include Item
    extend  Item
    attr_accessor :id
    
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
  
  module Product
    include Item
    extend  Item

    attr_accessor :id
    
    def self.key_symbol
      :zupId
    end
    
    def self.pluralize
      "Products"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9A-Fa-f]{32}/] ? true : false
    end
    
    self.instance_methods.each do |method|
      # puts method
      #module_function method.to_sym
    end
  end
  
  module Adspace
    include Item
    extend Item
    
    restrict :create, :read, :update, :delete
    
    attr_accessor :id
    
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

    attr_accessor :id
    restrict :create, :read, :update, :delete
    
    def self.key_symbol
      :saleId
    end
    
    def self.pluralize
      "Sales"
    end
    
    def self.is_key?(id)
      id.to_s[/[0-9]/] ? true : false
    end
    
    self.instance_methods.each do |method|
      # puts method
      #module_function method.to_sym
    end
  end
end


