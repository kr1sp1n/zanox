require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

# fake session
Zanox::API::Session.connect_id = 'your connect id'
Zanox::API::Session.secret_key = 'your secret key'

profile = Zanox::Profile.find()[0]

puts "Hi #{profile['firstName']}!"