Dir["models/*.rb"].each do |file|
require_relative file
end

class Restaurant < Sinatra::Base
register Sinatra::ActiveRecordExtension
enable :method_override

  # Console
  get '/console' do
    Pry.start(binding)
    ""
  end

  # Default route
  get '/' do
    erb :index
  end

#FOODS  
  get '/foods' do
    @menu = Food.all
    erb :'foods/index'
  end
  # As an employee, I want to be able to add new food items to the menu.
  get '/foods/new' do
    erb :'foods/new'
  end

  post '/foods' do
    food = Food.create(params[:food])
    redirect to "/foods/#{food.id}"
  end
  # As an employee, I want to be able to edit previously added food items, 
  get '/foods/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end
  #As an employee, I want to be able to delete previously added food items
  delete '/foods/:id' do
    food = Food.find(params[:id])
    food.destroy
    redirect to "/foods"
  end

  patch '/foods/:id' do |id|
    food = Food.find(id)
    food.update(params[:food])
    redirect to "/foods/#{food.id}"
  end  

  get '/foods/:id' do |id|
    @food = Food.find(id)
    erb :'foods/show'
  end 

# PARTIES
  get '/parties' do
    @party = Party.all
    erb :'parties/index'
  end

  get '/parties/new' do
    erb :'parties/new'
  end

  get '/parties/:id' do |id|
    @party = Party.find(id)
    @orders = @party.orders
    @foods = Food.all
    erb :'parties/show'
  end

  get '/parties/:id/order' do |id|
    @party = Party.find(id)
    @foods = Food.all
    erb :'orders/new'
  end 

  get '/parties/:id/receipt' do |id|
    @party = Party.find(id)
    erb :'parties/receipt'
  end

  post '/parties' do
    party = Party.create(params[:party])
    redirect to "parties/#{party.id}"
  end

  get '/parties/:id/edit' do |id|
    @party = Party.find(id)
    erb :'parties/edit'
  end

  patch '/parties/:id' do |id|
    @party = Party.find(id)
    @party.update(params[:party])
    @foods = Food.all
    redirect to "/parties/#{@party.id}"
  end  

  delete '/parties/:id' do
    party = Party.find(params[:id])
    party.destroy
    redirect to "/parties"
  end

# ORDERS
  get '/orders' do
    @order = Order.all
    erb :'orders/index'
  end

  get '/parties/new' do
    erb :'orders/new'
  end

  get '/order/:id' do |id|
    @order = Order.find(id)
    erb :'orders/show'
  end   

  post '/orders' do
    order = Order.create(params[:order])
    party = order.party.id
    redirect to "/orders/#{order.id}"
  end

  get '/orders/:id/edit' do |id|
    @order = Order.find(id)
    erb :'orders/edit'
  end

  delete '/orders/:id' do |id|
    order = Order.find(id)
    order.destroy
    redirect to "/orders"
  end

  patch '/orders/:id' do |id|
    order = Order.find(id)
    order.update(params[:order])
    redirect to "/orders/#{order.id}"
  end  

end















