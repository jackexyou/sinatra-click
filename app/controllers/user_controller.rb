require 'pry'

class UserController < ApplicationController 

	
	get '/signup' do

		erb :'users/signup'
	end

	post '/signup' do
		user = User.new(username: params[:username], password: params[:password])
		if user.save
			session[:user_id] = user.id
			redirect "/users/#{user.id}"
		else
			redirect '/signup'
		end
	end

	get '/login' do
		erb :'users/login'
	end

	post '/login' do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/users/#{user.id}"
		else
			redirect "/login"
		end
	end

	get '/users/:user_id' do
		@user = User.find_by(id: params[:user_id])
		erb :'users/show'
	end

	post '/users/:user_id' do
		if logged_in?
			current_user.update(clicks: current_user.clicks + 1)
			redirect "/users/#{current_user.id}"
		else 
			redirect to '/login'
		end
	end

	get '/logout' do
		session.clear
		redirect '/'
	end

end
