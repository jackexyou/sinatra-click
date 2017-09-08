class CreateRewards < ActiveRecord::Migration[5.1]
  def change
  	create_table :rewards do |t|
  		t.string :name
  		t.integer :cost
  	end
  end
end
