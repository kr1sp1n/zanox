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

TEST_CONNECT_ID = "668189244D19BABF75AC"
TEST_OFFLINE_TOKEN = "9B4D9964A7484E750EA80B841E1B31649F02D6E4FBBBC995778CA1A4F133949539E6FE"
TEST_PUBLIC_KEY = "3A58C794D2A828661803"
TEST_SECRET_KEY = "1e2d8dC839Fc4A+aa92207b1dc6c5C/849012B4c"

TEST_USER_FIRSTNAME = "Krispin"
TEST_ADSPACE_ID = "710796"

TEST_SALE_ID = "92ba89e7-b229-4933-857c-e307c0291856"
TEST_SALE_DATE = "2010-03-02T00:00:00"

class Test::Unit::TestCase
  def setup
    
    Zanox::API.authorize(TEST_PUBLIC_KEY, TEST_SECRET_KEY)
    Zanox::API::Session.offline(TEST_OFFLINE_TOKEN)
    
    #Zanox::API::Session.connect_id = TEST_CONNECT_ID
    #Zanox::API::Session.secret_key = TEST_SECRET_KEY
    
  end
end
