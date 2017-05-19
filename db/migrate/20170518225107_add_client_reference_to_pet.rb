class AddClientReferenceToPet < ActiveRecord::Migration
  def change
  	add_reference :pets, :races
  end
end
