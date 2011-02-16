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

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'zanox'

class Test::Unit::TestCase
  def setup
    Zanox::API.authorize("your app's public key", "your app's secret key")
    Zanox::API::Session.offline("a zanox Publisher's offline token")
    # or use Zanox::API::Session.new("a zanox Connect authtoken")
    #
    # please configure Puplisher specific constants in test_zanox.rb to make the tests runnable
    #
  end
end
