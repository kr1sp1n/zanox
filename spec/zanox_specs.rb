require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

describe Zanox::API::Client do
  
  TEST_USERNAME = "krispin"
  TEST_PASSWORD = "test123"
  TEST_LATEST_API_VERSION = Zanox::API.versions[:latest]
  
  before(:all) do
    @client = Zanox::API::Client.new
  end
  
  it "should use the latest Zanox::API version if not specified at initializing" do
    @client.api_version.should == TEST_LATEST_API_VERSION
  end
 
  it "should respond to 'login'" do
    @client.should respond_to(:login)
  end
 
  it "should return username and password after 'login' with 'to_s'" do
    @client.login(TEST_USERNAME, TEST_PASSWORD)
    str = @client.to_s
    str.should == TEST_USERNAME + ', ' + TEST_PASSWORD
  end
  
end