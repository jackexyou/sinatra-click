require 'pry'

class UserController < ApplicationController 

	
	get '/signup' do

		erb :'users/signup'
	end

	post '/signup' do
		user = User.create(username: params[:username], password: params[:password], clicks: 0)
		if user.save
			redirect '/login'
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
		@user = current_user
		@user.clicks += 1
		@user.save
		redirect "/users/#{@user.id}"
	end

	get '/logout' do
		session.clear
		redirect '/'
	end

end
