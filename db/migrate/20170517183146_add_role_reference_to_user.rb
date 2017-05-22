class AddRoleReferenceToUser < ActiveRecord::Migration
  def change
  	add_reference :users, :roles
  end
end
