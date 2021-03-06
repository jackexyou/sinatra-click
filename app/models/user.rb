class User < ActiveRecord::Base
	has_many :user_rewards
	has_many :rewards, through: :user_rewards
	has_secure_password
	validates :username, presence: true
	validates :username, uniqueness: true
end