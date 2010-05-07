require 'rubygems'
require 'zanox'

Zanox::API.authenticate('26EE1314AEA84BB7C9FC')

Zanox::Product.find('ipod').each do |product|
  puts product.id + " : " + product.name
end