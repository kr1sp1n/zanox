require 'soap/wsdlDriver'

module Zanox
  
  class ZanoxSoap < ZanoxBase
    
    attr_accessor :service, :wsdl, :soap
    
    def initialize
      @service = 'publisherservice'
      @wsdl = 'http://api.zanox.com/wsdl'
      @soap = false
    end
    
    def get_adspaces
      method = 'GetAdspaces'
        
      enable_api_security

      if result = send_request(method) 
        return result
      end

      return false
    end
    
    def get_adspace(adspace_id)
      method = 'GetAdspace'
        
      params = {'adspaceId' => adspace_id.to_s }
      
      enable_api_security
      
      if result = send_request(method, params) 
        return result
      end

      return false      
    end
    
#    def create_adspace(adspace_item, lang = 'en')#FIXME
#      method = 'CreateAdspace'
#    end
#    
#    def update_adspace(adspace_id, adspace_item)#FIXME
#      method = 'UpdateAdspace'
#    end
    
    def delete_adspace(adspace_id)
      method = 'DeleteAdspace'
      
      params = { 'adspaceId' => adspace_id.to_s }
      
      enable_api_security
      
      if send_request(method, params) 
        return true
      end

      return false     
    end
    
    def get_program(program_id)
      method = 'GetProgram'
        
      params = { 'programId' => program_id.to_s }

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false
    end

    def get_programs(category_id = false, page = 0, items = 10)
      method = 'GetPrograms'
      
      params = {
        'page' => page,
        'items' => items,
        'adspaceId' => 0,
        'categoryId' => 0
      }
      
      if ( category_id )
        params['categoryId'] = category_id.to_s
      end

      disable_api_security
        
      if  result = send_request(method, params)
        return result
      end

      return false          	
    end
    
    def search_programs(q, page = 0, items = 10)
      method = 'SearchPrograms'
        
      params = {
        'query' => q,
        'page' =>  page,
        'items' => items,
        'categoryId' => 0
      }

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false          
    end
    
    def get_program_news
      method = 'GetProgramPromotions'

      disable_api_security

      if  result = send_request(method)
        return result
      end

      return false 
    end
    
    def get_program_categories
      method = 'GetProgramCategories'
      
      disable_api_security

      if  result = send_request(method)
        return result
      end

      return false 
    end
    
    def get_programs_by_adspace(adspace_id, page = 0, items = 10)
      method = 'GetPrograms'
        
      params = {
        'page' => page,
        'items' => items,
        'adspaceId' => adspace_id.to_s,
        'categoryId' => 0
      }

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false        
    end
    
#    def create_program_application(program_id, adspace_id)#FIXME
#      method = 'CreateProgramApplication'
#    end
    
    def delete_program_application(program_id, adspace_id)#TODO test
      method = 'DeleteProgramApplication'
        
      params = { 
        'programId' => program_id.to_s, 
        'adspaceId' => adspace_id.to_s
      }

      enable_api_security

      if  send_request(method, params)
          return true
      end

      return false     
    end
    
    def get_product(zup_id)
      method = 'GetProduct'
        
      params = {'zupId' => zup_id.to_s }

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false  
    end
    
    def get_products_by_program(program_id, filter = {}, page = 0, items = 10)
      method = 'GetProducts'
        
      params = { 
        'programId' => program_id.to_s,
        'page' => page,
        'items' => items,
        'adspaceId' => 0
      } 

      if ( !filter['adspace'].blank? )
        params['adspaceId'] = filter['adspace']     
      end
      
      if ( !filter['modified'].blank? )
        params['modifiedDate'] = filter['modified']     
      end       

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false    
    end
    
    def search_products(q, filter = {}, page = 0, items = 10)
      method = 'SearchProducts'
        
      params = {
        'query' => q, 
        'page' => page,
        'items' => items,
        'adspaceId' => 0 
      }

      if ( !filter['adspace'].blank? )
        params['adspaceId'] = filter['adspace']     
      end  

      if ( !filter['region'].blank? &&  filter['region'].size == 2)
        params['region'] = filter['region']     
      end  
      
      if ( !filter['minprice'].blank? )
        params['minPrice'] = filter['minprice']     
      end 
      
      if ( !filter['maxprice'].blank? )
        params['maxPrice'] = filter['maxprice']     
      end 

      if ( !filter['ip'].blank? )
        params['ipAddress'] = filter['ip']     
      end
      
      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false    
    end
    
    def get_admedium(admedium_id)
      method = 'GetAdmedium'
        
      params = { 
        'admediaId' => admedium_id.to_s,
        'adspaceId' => 0
      }

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false   
    end
    
    def get_admedia_by_program(program_id, filter = {}, page = 0, items = 10)
      method = 'GetAdmedia'
      
      params = { 
        'programId' => program_id.to_s, 
        'page' => page,
        'items' => items,
        'categoryId' => 0,
        'type' => 0,
        'format' => 0,   
        'adspaceId' => 0
      }
      
      if ( !filter['adspace'].blank? )
        params['adspaceId'] = filter['adspace']     
      end

      if ( !filter['category'].blank? )
        params['goryId'] = filter['category']     
      end

      if ( !filter['type'].blank? )
        params['type'] = filter['type']     
      end
      
      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false   
    end
    
    def get_admedia_categories_by_program(program_id)
      method = 'GetAdmediumCategories'
        
      params = { 'programId' => program_id.to_s }

      disable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false   
    end
    
    def get_sales(filter = {}, page = 0, items = 10)
      method = 'GetSales'
        
      params = { 
        'page' => page,
        'items' => items
      }

      if ( !filter['date'].blank? )
        params['date'] = filter['date']     
      end
      
      if ( !filter['modifieddate'].blank? )
        params['modifieddate'] = filter['modifieddate']     
      end
      
      if ( !filter['clickdate'].blank? )
        params['clickdate'] = filter['clickdate']     
      end

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false  
    end
    
    def get_leads(filter = {}, page = 0, items = 10)
      method = 'GetLeads'
        
      params = {
        'page' => page,
        'items' => items
      }

      if ( !filter['date'].blank? )
        params['date'] = filter['date']     
      end
      
      if ( !filter['modifieddate'].blank? )
        params['modifieddate'] = filter['modifieddate']     
      end
      
      if ( !filter['clickdate'].blank? )
        params['clickdate'] = filter['clickdate']     
      end

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false    
    end
    
    def get_payments(page = 0, items = 10)
      method = 'GetPayments'
        
      params = { 
        'page' => page,
        'items' => items
      }

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false  
    end
    
    def get_payment(payment_id)
      method = 'GetPayments'
        
      params = { 'paymentId' => payment_id.to_s }

      #just has to be set to false to work around the bug 
      # 3 lines can be removed after fixing        
      params['page'] = page
      params['items'] = items      

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false         
    end
    
    def get_balances
      method = 'GetBalances'
        
      enable_api_security

      if  result = send_request(method)
        return result
      end

      return false     
    end
    
    def get_balance(currency_code)
      method = 'GetBalances'
        
      params = { 'currency' => currency_code }

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false        
    end
    
    def get_accounts
      method = 'GetAccounts'
        
      enable_api_security

      if  result = send_request(method)
        return result
      end

      return false       
    end
    
    def get_account(account_id)
      method = 'GetAccounts'
        
      params = { 'accountId' => account_id }

      enable_api_security

      if  result = send_request(method, params)
        return result
      end

      return false    
    end
    
    def get_profile
      method = 'GetProfile'
        
      enable_api_security

      if  result = send_request(method)
        return result
      end

      return false   
    end
    
#    def update_profile(profile_item)#FIXME
#      method = 'UpdateProfile'
#    end
    
    def get_timestamp
      timestamp = Time.now.gmtime 
      timestamp = timestamp.strftime("%Y-%m-%dT%H:%M:%S.000Z")
      timestamp.to_s
    end
    
    def send_request(method, params = {})
      params['applicationId'] = @application_id

      if @api_security
        params['timestamp'] = get_timestamp
        params['signature'] = build_signature(method)
      end

      begin
        proxy = SOAP::WSDLDriverFactory.new(@wsdl).create_rpc_driver 
        case method
          when 'GetAdspaces'
            res = proxy.GetAdspaces(params) 
          when 'GetAdspace'
            res = proxy.GetAdspace(params) 
          when 'CreateAdspace'
            res = proxy.CreateAdspace(params) 
          when 'UpdateAdspace'
            res = proxy.UpdateAdspace(params) 
          when 'DeleteAdspace'
            res = proxy.DeleteAdspace(params) 
          when 'GetProgram'
            res = proxy.GetProgram(params) 
          when 'GetPrograms'
            res = proxy.GetPrograms(params) 
          when 'SearchPrograms'
            res = proxy.SearchPrograms(params) 
          when 'GetProgramPromotions'
            res = proxy.GetProgramPromotions(params) 
          when 'GetProgramCategories'
            res = proxy.GetProgramCategories(params) 
          when 'CreateProgramApplication'
            res = proxy.CreateProgramApplication(params) 
          when 'DeleteProgramApplication'
            res = proxy.DeleteProgramApplication(params) 
          when 'GetProduct'
            res = proxy.GetProduct(params) 
          when 'GetProducts'
            res = proxy.GetProducts(params) 
          when 'SearchProducts'
            res = proxy.SearchProducts(params) 
          when 'GetAdmedium'
            res = proxy.GetAdmedium(params) 
          when 'GetAdmedia'
            res = proxy.GetAdmedia(params) 
          when 'GetAdmediumCategories'
            res = proxy.GetAdmediumCategories(params) 
          when 'GetSales'
            res = proxy.GetSales(params)
          when 'GetLeads'
            res = proxy.GetLeads(params)
          when 'GetPayments'
            res = proxy.GetPayments(params)
          when 'GetBalances'
            res = proxy.GetBalances(params)
          when 'GetAccounts'
            res = proxy.GetAccounts(params)
          when 'GetProfile'
            res = proxy.GetProfile(params)
          when 'UpdateProfile'
            res = proxy.UpdateProfile(params)
        end
        
        return res
      rescue Exception => e
        @last_error_msg = e.to_s
      end

      return false
    end
    
    private
    
    def build_signature(method)
      sign = @service + method.downcase + get_timestamp

      if hmac = get_hmac_signature(sign)
        return hmac
      end

      return false
    end  
    
  end
  
end
