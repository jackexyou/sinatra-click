class RewardController < ApplicationController 

	get '/rewards' do 
		@rewards =  Reward.all

		erb :"rewards/index"
	end

end