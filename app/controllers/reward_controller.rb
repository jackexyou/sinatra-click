require 'pry'

class RewardController < ApplicationController 

	get '/rewards' do 
		@rewards = Reward.all
		erb :"rewards/index"
	end


	post '/rewards' do
		@user = current_user
		@reward = Reward.find_by(name: params['name'])
		@user_reward = UserReward.find_or_create_by(user_id: @user.id, reward_id: @reward.id)
		if @user.clicks >= @reward.cost
			@user.update(clicks: @user.clicks - @reward.cost)
			@user_reward.update(quantity: @user_reward.quantity + 1)
			redirect "/users/#{@user.id}"
		else
			redirect "/rewards"
		end
	end

	get '/rewards/new' do
		erb :"rewards/new"
	end

	post '/rewards/new' do
		if params['cost'].to_i <= 0
			redirect "/rewards/new"
		end
		@reward = Reward.create(name: params['name'], cost: params['cost'])
		redirect "/rewards"
	end

	get '/rewards/:id' do 
		@reward = Reward.find(params[:id])
		@user_reward = UserReward.find_or_create_by(user_id: current_user.id, reward_id: @reward.id)
		erb :'rewards/show'
	end

	patch '/rewards/:id' do
		if params['cost'].to_i <= 0
			redirect "/rewards/#{params[:id]}"
		end

		@reward = Reward.find(params[:id])
		@user_reward = UserReward.find_or_create_by(user_id: current_user.id, reward_id: @reward.id)
		@reward.update(name: params['name'], cost: params['cost'])
		if !params['quantity'].blank?
			@user_reward.update(quantity: params["quantity"])
		end
		redirect "users/#{current_user.id}"

	end

	delete '/rewards/:id/delete' do
		@reward = Reward.find(params[:id])
		@reward.destroy
		redirect '/rewards'
	end



	# Show Reward = GET
	# Edit Reward = GET - only by the user who owns it
	# Update Reward = PUT - only by the user who owns it
	# Delete Reward = DELETE - only by the user who owns it

end