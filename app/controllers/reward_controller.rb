require 'pry'

class RewardController < ApplicationController 

	get '/rewards' do 
		@user = current_user
		@rewards = Reward.all

		erb :"rewards/index"
	end

	post '/rewards' do 
		@user = current_user
		@reward = Reward.find_by(name: params['name'])
		@user_reward = UserReward.find_or_create_by(user_id: @user.id, reward_id: @reward.id)
		if @user.clicks >= @reward.cost
			@user.clicks -= @reward.cost
			@user.save
			@user_reward.quantity += 1
			@user_reward.save
			redirect "/users/#{@user.id}"
		else
			redirect "/rewards"
		end
	end

end