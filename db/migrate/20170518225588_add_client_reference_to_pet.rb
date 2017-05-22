class AddClientReferenceToPet < ActiveRecord::Migration
  def change
  	add_reference :pets, :client
  end
end
