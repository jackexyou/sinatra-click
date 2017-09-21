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
		binding.pry
		if @user.clicks >= @reward.cost
			@user.update(clicks: @user.clicks - @reward.cost)
			@user_reward.update(quantity: @user_reward.quantity + 1)
			redirect "/users/#{@user.id}"
		else
			redirect "/rewards"
		end
	end

	get '/rewards/:id' do 
		@reward = Reward.find(params[:id])
		@user_reward = UserReward.find_or_create_by(user_id: current_user.id, reward_id: @reward.id)
		erb :'rewards/show'
	end

	patch '/rewards/:id' do  
		@reward = Reward.find(params[:id])
		@user_reward = UserReward.find_or_create_by(user_id: current_user.id, reward_id: @reward.id)
		@user_reward.update(quantity: params["quantity"])
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