require "net/http"
require "uri"

module Zanox
  
  class ZanoxXml < ZanoxBase

    def initialize(version = false)
      @version = version
      @rest_action = 'GET'
      @url = 'http://api.zanox.com/xml'
      @content_type = 'application/xml'      
      @raw_data_disabled = true
    end
    
    def get_adspaces
      resource = ['adspaces']
        
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource) 
        return result
      end

      return false      
    end
    
    def get_adspace(adspace_id)
      resource = ['adspaces', 'adspace', adspace_id.to_s]
        
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource) 
        return result
      end

      return false      
    end
    
#    def create_adspace(adspace_item, lang = 'en')#TODO test
#      resource = ['adspaces', 'adspace']
#        
#      @rest_action = 'POST'
#      enable_api_security
#
#      body = serialize('adspaceItem', adspace_item, lang);
#
#      if send_request(resource, false, body) 
#          return true
#      end
#
#      return false     
#    end
    
#    def update_adspace(adspace_id, adspace_item)#TODO test
#      resource = ['adspaces', 'adspace', adspace_id.to_s]
#        
#      @rest_action = 'PUT'
#      enable_api_security
#
#      body = serialize('adspaceItem', adspace_item);
#
#      if send_request(resource, false, body) 
#          return true
#      end
#
#      return false
#    end
    
    def delete_adspace(adspace_id)
      resource = ['adspaces', 'adspace', adspace_id.to_s]
      
      @rest_action = "DELETE"
      enable_api_security
      
      if send_request(resource)
        return true
      end

      return false
    end
    
    def get_program(program_id)
      resource = ['programs', 'program', program_id.to_s]
        
      @rest_action = "GET"
      disable_api_security

      if result = send_request(resource)
        return result
      end

      return false
    end
      
    def get_programs(category_id = false, page = 0, items = 10)
      if category_id
        resource = ['programs', 'category', category_id.to_s]
      else 
        resource = ['programs']
      end

      query = {'page' => page, 'items' => items}

      @rest_action = "GET"
      disable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false  	
    end
    
    def search_programs(q, page = 0, items = 10)  
      resource = ['programs']
      query = {'q' => q, 'page' => page, 'items' => items}
        
      @rest_action = 'GET'
      disable_api_security
        
      result = send_request(resource, query)

      return result
    end
    
    def get_program_news
      resource = ['programs', 'news']
        
      @rest_action = 'GET'
      disable_api_security

      result = send_request(resource)

      return result      
    end
    
    def get_program_categories
      resource = ['programs', 'categories']
        
      @rest_action = 'GET'
      disable_api_security

      result = send_request(resource)

      return result
    end
    
    def get_programs_by_adspace(adspace_id, page = 0, items = 10)
      resource = ['programs', 'adspace', adspace_id.to_s]
      query    = {'page' => page, 'items' => items}

      @rest_action = 'GET'
      enable_api_security

      result = send_request(resource, query)

      return result
    end
    
#    def create_program_application(program_id, adspace_id)#TODO test
#      resource = ['programs', 'program', program_id.to_s, 'adspace', adspace_id.to_s]
#        
#      @rest_action = 'POST'
#      enable_api_security
#
#      if send_request(resource, false, 'hallo')
#          return true
#      end
#
#      return false
#    end
    
    def delete_program_application(program_id, adspace_id)#TODO test
      resource = ['programs', 'program', program_id.to_s, 'adspace', adspace_id.to_s]
        
      @rest_action = 'DELETE'
      enable_api_security

      if send_request(resource)
        return true
      end

      return false
    end
    
    def get_product(zup_id)
      resource = ['products', 'product', zup_id.to_s]

      @rest_action = 'GET'
      disable_api_security

      if result = send_request(resource)
        return result
      end

      return false      
    end
    
    def get_products_by_program(program_id, filter = {}, page = 0, items = 10)
      if !filter['adspace'].blank?
        resource = ['products', 'program', program_id.to_s, 'adspace', filter['adspace']]
      else 
        resource = ['products', 'program', program_id.to_s]
      end        

      query = {'page' => page, 'items' => items}

      if !filter['modified'].blank?
        query['modified'] = filter['modified']
      end

      @rest_action = 'GET'
      disable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false      
    end
    
    def search_products(q, filter = {}, page = 0, items = 10)
      if !filter['adspace'].blank?
        resource = ['products', 'adspace', filter['adspace']]
      else 
        resource = ['products']        
      end

      query = {'q' => q, 'page' => page, 'items' => items}

      if  !filter['region'].blank? && filter['region'].length == 2
        query['region'] = filter['region']
      end

      if !filter['minprice'].blank?
        query['minprice'] = filter['minprice']
      end

      if !filter['maxprice'].blank?
        query['maxprice'] = filter['maxprice']
      end

      if !filter['ip'].blank?
        query['ip'] = filter['ip']
      end

      @rest_action = 'GET'
      disable_api_security
      
      if result = send_request(resource, query)
        return result
      end

      return false
    end
    
    def get_admedium(admedium_id)
      resource = ['admedia', 'admedium', admedium_id.to_s]
        
      @rest_action = 'GET'
      disable_api_security

      if result = send_request(resource)
        return result
      end

      return false
    end
    
    def get_admedia_by_program(program_id, filter = {}, page = 0, items = 10)
      if !filter['category'].blank?
        resource = ['admedia', 'program', program_id.to_s, 'category', filter['category']]
      elsif !filter['type'].blank?
        resource = ['admedia', 'program', program_id.to_s, 'type', filter['type']]      
      else 
        resource = ['admedia', 'program', program_id.to_s]
      end        

      query = {'page' => page, 'items' => items}

      @rest_action = 'GET'
      disable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false
    end
    
    def get_admedia_categories_by_program(program_id)
      resource = ['admedia', 'program', program_id.to_s, 'categories']
        
      @rest_action = 'GET'
      disable_api_security

      if result = send_request(resource)
        return result
      end

      return false
    end
    
    def get_sales(filter = {}, page = 0, items = 10)
      resource = ['reports', 'sales']
        
      query = {'page' => page, 'items' => items}

      if !filter['date'].blank?
        query['date'] = filter['date']
      end

      if !filter['modifieddate'].blank?
        query['modifieddate'] = filter['modifieddate']
      end

      if !filter['clickdate'].blank?
        query['clickdate'] = filter['clickdate']
      end

      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false
    end
    
    def get_leads(filter = {}, page = 0, items = 10)
      resource = ['reports', 'leads']
        
      query = {'page' => page, 'items' => items}

      if !filter['date'].blank?
        query['date'] = filter['date'];
      end

      if !filter['modifieddate'].blank?
        query['modifieddate'] = filter['modifieddate']
      end

      if !filter['clickdate'].blank?
        query['clickdate'] = filter['clickdate']
      end

      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false     
    end
    
    def get_payments(page = 0, items = 10)
      resource = ['payments']
        
      query = {'page' => page, 'items' => items}

      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource, query)
        return result
      end

      return false 
    end
    
    def get_payment(payment_id)
      resource = ['payments', 'payment', payment_id]
                
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource)
        return result
      end

      return false     
    end
    
    def get_balances
      resource = ['payments', 'balances']
                
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource)
        return result
      end

      return false       
    end
    
    def get_balance(currency_code)
      resource = ['payments', 'balances', 'balance', currency_code]
                
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource)
        return result
      end

      return false  
    end
    
    def get_accounts
      resource = ['payments', 'accounts']
                
      @rest_action = 'GET'
      enable_api_security

      if result = send_request(resource)
        return result
      end

      return false       
    end
    
    def get_account(account_id)
      resource = ['payments', 'accounts', 'account', account_id.to_s]
                
      @rest_action = 'GET'
      enable_api_security
      
      if result = send_request(resource)
        return result
      end

      return false        
    end
    
    def get_profile
      resource = ['profiles']
        
      @rest_action = 'GET'
      enable_api_security

      result = send_request(resource, false)

      return result
    end
    
#    def update_profile(profile_item)#TODO test
#      resource = ['profiles']
#
#      @rest_action = 'PUT'
#      enable_api_security
#
#      body = serialize('profileItem', profile_item)
#
#      if send_request(resource, false, profile_item)
#        return true
#      end
#
#      return false
#    end
    
    def get_timestamp
      timestamp = Time.now.gmtime 
      timestamp = timestamp.strftime("%a, %d %b %Y %H:%M:%S GMT")
      timestamp.to_s
    end
    
    def enable_raw_data
      @raw_data_disabled = true
    end
    
    def disable_raw_data
      @raw_data_disabled = false
    end
    
    private
    
    def send_request(resource, query = {}, body = false) 
      version  = false
      uri_path = "/" + resource.join("/")
      timestamp = get_timestamp
      
      if @api_security
        shash = build_signature(uri_path, timestamp)
        authorization = "ZXWS " + @application_id + ":" + shash
      else 
        authorization = "ZXWS " + @application_id
      end
      
      if @version
        version =  "/" + @version
      else
        version = ""
      end
      
      request_url = @url + version +  uri_path
      
      url = URI.parse(request_url)
      path = url.path
      path = path + '?' + query.to_query if query.is_a?(Hash) && !query.empty?
      
      case @rest_action
        when 'GET'
          req = Net::HTTP::Get.new(path)
        when 'PUT'
          req = Net::HTTP::Put.new(path)
        when 'POST'
          req = Net::HTTP::Post.new(path)
        when 'DELETE'
          req = Net::HTTP::Delete.new(path)
      end
     
      req.add_field("authorization", authorization)
      req.add_field("date", timestamp)
      req.add_field("user-agent", "zanox PHP API Client")
      req.add_field("content-type" , @content_type)
      req.add_field("host" , "api.zanox.com")

      res = Net::HTTP.new(url.host, url.port).start do |http|
        http.request(req)
      end
      
      if res.code == '200'
        return res.body
      end
      
      @last_error_msg = res.message
      
      return false
    end
    
    def build_signature(uri, timestamp)
      sign = @rest_action + uri + timestamp
      if ( hmac = get_hmac_signature(sign) )
        return hmac
      end     

      return false
    end
    
#    def serialize#TODO implement
#      
#    end
    
  end

end
