require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

$DEBUG = true

Zanox::API.wsdl = "http://t-wdw-01.zanox.com/api/wsdl/2010-07-01/publisher.wsdl"
Zanox::API.authenticate('80CC6774346A37AEE51B', 'beaFdE2e855842+CA3cd163a4EB3f1/a7002eb43')

#Zanox::API.authenticate('A1853B8432094AA86075', '6b627cc49DB045+887b642848F722b/59f09b749')

def show(items, *args)
  puts "\nFound items: "+items.size.to_s+"\n"
  items.each do |item|
    line = ""
    args.each do |arg|
      if(arg.is_a?(Symbol)) 
        if(item.respond_to?(arg))
          line.concat(item.method(arg).call)
        end
      elsif(arg.is_a?(String))
        line.concat(arg)
      end
    end
    puts line
  end
end

# PRODUCTS #
############

# find products by keywords
products = Zanox::Product.find('ipod')
show products, "Product ", :id, "\t\"", :name, "\" - ", :price, " ", :currency
# or find specific product by id
product_id = products[0].id
products = Zanox::Product.find(product_id)
show products, "Product ", :id, "\t\"", :name, "\" - ", :price, " ", :currency

# ADSPACES #
############

# find all your Adspaces
adspaces = Zanox::Adspace.find(:all)
show adspaces, "Adspace ", :id, "\t\"", :name, "\""

# or find specific Adspace by id
adspace_id = adspaces[0].id
adspaces = Zanox::Adspace.find(adspace_id)
show adspaces, "Adspace ", :id, "\t\"", :name, "\""

# PROGRAMS #
############

# find zanox programs by keywords
programs = Zanox::Program.find('amazon')
show programs, "Program ", :id, "\t\"", :name, "\""

# or find specific zanox programs by id
program_id = programs[0].id
programs = Zanox::Program.find(program_id)
show programs, "Program ", :id, "\t\"", :name, "\""

# or find programs that are registered with one of your Adspaces
programs = Zanox::Program.find(:adspaceId => adspace_id)
show programs, "Program ", :id, "\t\"", :name, "\""

# SALES #
#########

puts "\nSALES"
# find a sale by date
date = "2010-03-02T00:00:00"
sales = Zanox::Sale.find(:date=>date, :dateType=>'trackingDate')
show sales, "Sale ", :id, " ", :commission, " EUR - ", :reviewState

# get zpar
sales[0].gpps.gpp.each do |gpp|
  puts gpp.xmlattr_id + " = " + gpp
end

# MEDIASLOTS #
##############

# find all your MediaSlots
mediaslots = Zanox::MediaSlot.find(:all, :items=>99)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""
# or find a specific MediaSlot
mediaslot_id = mediaslots[0].id
mediaslots = Zanox::MediaSlot.find(mediaslot_id)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""
# or find Mediaslots by adspace id
mediaslots = Zanox::MediaSlot.find(:adspaceId=>adspace_id, :items=>99)
show mediaslots, "MediaSlot ", :id, " \"", :name, "\""