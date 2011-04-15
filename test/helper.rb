require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'redgreen'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'zanox'

TEST_CONNECT_ID = "your connect id"
TEST_OFFLINE_TOKEN = "your offline token"
TEST_PUBLIC_KEY = "your public key as developer for the specific app"
TEST_SECRET_KEY = "your secret key as developer for the specific app"

TEST_USER_FIRSTNAME = "your test publisher user name"
TEST_ADSPACE_ID = "your test adspace id"

TEST_SALE_ID = "your test sale id"
TEST_SALE_DATE = "2010-03-02T00:00:00"

class Test::Unit::TestCase
  def setup
    
    Zanox::API.public_key = TEST_PUBLIC_KEY
    Zanox::API.secret_key = TEST_SECRET_KEY
    Zanox::API::Session.offline(TEST_OFFLINE_TOKEN)
    
    #Zanox::API::Session.connect_id = TEST_CONNECT_ID
    #Zanox::API::Session.secret_key = TEST_SECRET_KEY
    
  end
end
