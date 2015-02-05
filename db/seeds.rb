require 'pg'
require 'active_record'
require 'pry'


Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant",
  host: "localhost" 
)

# Food.destroy_all
# Party.destroy_all
# Order.destroy_all

#FOODS
[
  {
    name: 'Bacon Tater tots',
    cuisine: 'American' ,
    price: 5,
    allergens: 'Red Meat & Gluten' 
  },

  {
    name: 'Oysters',
    cuisine: 'Seafood' ,
    price: 12,
    allergens: 'Shellfish'
  },

  {
    name: 'Warm Beet Salad' ,
    cuisine: 'French',
    price: 14,
    allergens: 'Dairy & Nuts'  
  },

  {
    name: 'Cardamom Panna Cotta',
    cuisine: 'Italian',
    price: 12 ,
    allergens: 'Dairy, Nuts & Gluten' 
  }

].each do |food|
  Food.create(food)
end

#PARTIES 
[
  {
    table_number: 1 ,
    guests: 4,
    paid: false    
  }, 

  {
    table_number: 2,
    guests: 2,
    paid: false    
  },
  {
    table_number: 3,
    guests: 3,
    paid: false    
  }  
].each do |party|
  Party.create(party)
end


[
  {
    food_id: 1,
    party_id: 1,      
  }, 

  {
    food_id: 2,
    party_id: 1,      
  }, 

  {
    food_id: 3,
    party_id: 2,      
  },    
  {
    food_id: 4,
    party_id: 2,      
  }     

].each do |order|
  Order.create(order)
end

