require File.join(File.dirname(__FILE__),"..","lib","zanox")
require 'test/unit'
 
class ZanoxTest < Test::Unit::TestCase
  
  def setup
    @zanox_client = Zanox::Client.new()
  end
 
  def test_api_version_not_empty
    assert_not_nil @zanox_client.api_version
  end
  
end