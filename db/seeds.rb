# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Produto.create!( [
    { :nome => "Agile Software Development", :preco => 30 },
    { :nome => "Dark Sun Campaign Setting", :preco => 25 },
    { :nome => "Neuromancer", :preco => 20}
  ] )