class Waiter < ActiveRecord::Base
	attr_reader :password

	validates :name, presence: true
	validates :password_digest, presence: true
	validates :password, length: { minimum: 6, allow_nil: true }

def self.find_by_credentials(args = {})
	waiter = Waiter.find_by(name: args[:name])

	if user.is_password?(args[:password])
		return waiter
	else
		return nil 
	end
end

def password=(pwd)
	@password = pwd
	self.password_digest = BCrypt::Password.create(pwd)
	self.save
end

def is_password?(pwd)
	bcrypt_pwd = BCrypt::Password.new(self.password_digest)
		return bcrypt_pwd.is_password?(pwd)
	end
end

class WaiterAuth < Sinatra::Base
	set :method_override, true
	enable :sessions

	get '/console' do 
		Pry.start(binding)
	end

# Need a way to sign up

	get '/signup' do
		@waiter = Waiter.new
		erb :'waiterauth/signup'	
	end

	post '/signup' do
		@waiter = Waiter.new( name: params[:waiter][:name])

		if params[:waiter][:password] == params[:waiter][:password_confirmation]
			@waiter.password = params[:waiter][:password]

			if @waiter.save
				login!(@user)

				redirect to ('/index')
			else
				erb :'waiterauth/signup'
			end
		else 
			@user.errors.add(:password, "and confirmation need to match.")

			erb :'waiterauth/signup'
		end
	end

# Need a way to sign in

	get '/login' do
		@waiter = Waiter.new

		erb :'waiterauth/login'
	end

	post '/login' do
		@waiter = Waiter.find_by_credentials(params[:waiter])

		if @waiter
			login!(@user)

			redirect to ('/waiterauth/index')
		else 
			@waiter = Waiter.new(name: params[:waiter][:name])

			@waiter.errors.add(:password, "and email are not a valid combination.")
			erb :'waiterauth/login'
		end
	end

# Need a way to sign out

delete '/logout' do 
	logout!
	redirect to ('waiterauth/login')
end

# Need a way to check we're signed in

	get '/welcome' dp 
	@waiter = current_waiter
	erb :'waiterauth/welcome'
	end

	private
	def create_token
		return SecureRandom.urlsafe_base64	
	end

	def current_user
		Waiter.find_by(authorization_token: session[:authorization_token])
	end

	def login!(user)
		waiter.authorization_token = session[:authorization_token] = create_token
		
		waiter.save
	end

	def logout!
		waiter = current_waiter
		wiater.authorization_token = session[:authorization_token] = nil
		
		waiter.save
	end
end



















