class UpdateClicksColumnInUserTable < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :clicks, :integer, default: 0
  end
end
