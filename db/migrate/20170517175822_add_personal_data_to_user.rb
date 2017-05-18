class AddPersonalDataToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :lastname, :string
  	add_column :users, :phone, :integer 
  end
end
