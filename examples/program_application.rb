require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

# fake session
Zanox::API::Session.connect_id = 'your connect id'
Zanox::API::Session.secret_key = 'your secret key'

program_applications = Zanox::ProgramApplication.find(:items=>50)

program_applications.each do |p|
  puts "#{p.adspace} #{p.status} for #{p.program}"
end