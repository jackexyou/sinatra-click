class AddQuantityToUserReward < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_rewards, :quantity, :integer
  end
end
