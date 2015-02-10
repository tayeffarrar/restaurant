require 'sinatra'
require 'sass'

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
    @food = Food.new
    erb :'foods/new'
  end

  post '/foods' do
    @food = Food.new(params[:food])
    if @food.save
      redirect to "/foods/#{@food.id}"
    else
      erb :'foods/new'
    end
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
    @order = Order.new(partyid: @party.id)
    erb :'orders/new'
  end 

  get '/parties/:id/receipt' do |id|
    @party = Party.find(id)
    erb :'parties/receipt'
  end

  post '/parties' do
    @party = Party.new(params[:party])
    if @party.save
      redirect to "/parties/#{@party.id}"
    else
      erb :'parties/new'
    end   
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
    @party = Party.find(params[:id])
    @party.destroy
    redirect to "/parties"
  end

# ORDERS
  get '/parties/:party_id/orders' do |party_id|
    @party = Party.find(party_id)
    @order = @party.orders
    erb :'orders/index'
  end

  get '/parties/:party_id/orders/:id' do |party_id, id|
    @party = Party.find(party_id)
    @order = Order.find(id)
    erb :'orders/show'
  end   

  post '/parties/:party_id/orders' do |party_id|
    @party = Party.find(party_id)
    @order = Order.create(params[:order])
    redirect to "/parties/#{@party.id}/orders/#{@order.id}"
  end

  # get '/parties/:party_id/orders/:id/edit' do |party_id, id|
  #   @order = Order.find(id)
  #   erb :'orders/edit'
  # end

  delete '/parties/:party_id/orders/:id' do |party_id, id|
    @order = Order.find(id)
    @order.destroy
    redirect to "/orders"
  end

  # patch '/parties/:party_id/orders/:id' do |party_id, id|
  #   @order = Order.find(id)
  #   @order.update(params[:order])
  #   redirect to "/parties/#{@party.id}"
  # end  

  get '/parties/:party_id/receipt' do |party_id|
    @party = Party.find(party_id)
    @order = @party.orders
    erb :'parties/receipt'
  end


end















