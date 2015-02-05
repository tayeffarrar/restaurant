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

  get '/foods/new' do
    erb :'foods/new'
  end

  post '/foods' do
    food = Food.create(params[:food])
    redirect to '/foods/#{food.id}'
  end

  get '/foods/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end

  delete '/foods/:id' do
    food = Food.find(params[:id])
    food.destroy
    redirect to '/foods'
  end
  
  patch '/foods/:id' do |id|
    food = Food.find(id)
    food.update(params[:food])
    redirect to '/foods/#{food.id}'
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
    @available = Party.opentables
    erb :'parties/new'
  end

  post '/parties' do
    party = Party.create(params[:party])
    redirect to '/parties/#{party.id}'
  end

  get '/parties/:id/edit' do
    @party = Party.find(params[:id])
    erb :'parties/edit'
  end

  delete '/parties/:id' do
    party = Party.find(params[:id])
    party.destroy
    redirect to '/parties'
  end
  
  patch '/parties/:id' do |id|
    party = Party.find(id)
    party.update(params[:party])
    redirect to '/parties/#{party.id}'
  end  
  
  get '/parties/:id' do |id|
    @party = Party.find(id)
    erb :'parties/show'
  end 


end


























