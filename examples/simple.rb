require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

Zanox::API.authenticate('your connect id here', 'your secret key here')

# find products by keywords
products = Zanox::Product.find('ipod')
# or find specific product by id
# products = Zanox::Product.find('afdd090e0ee25e796e5146f6fcd7b15e')
puts "\nFound zanox products:\n"
products.each do |product|
  puts product.name
end 

# find zanox programs by keywords
programs = Zanox::Program.find('amazon')
# or find specific zanox programs by id
#programs = Zanox::Program.find(1648)
puts "\nFound zanox Programs:\n"
programs.each do |program|
  puts program.name
end

# find specific user Adspace by id
#adspaces = Zanox::Adspace.find(1289612)
# or find all user's Adspaces
adspaces = Zanox::Adspace.find(:all)
puts "\nFound zanox Adspaces:\n"
adspaces.each do |adspace|
  puts adspace.id + " " + adspace.name
end

# find a sale by date
date = "2010-03-02T00:00:00"
sales = Zanox::Sale.find(:date=>date, :dateType=>'trackingDate')
puts "\nFound zanox Sales:\n"
sales.each do |sale|
  puts sale.commission + " EUR - " + sale.reviewState
end