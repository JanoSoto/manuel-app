class AddIndexesToClients < ActiveRecord::Migration
  def change
  	add_index :clients, :clientRut, :unique => true
  	add_index :clients, :clientEmail, :unique => true
  end
end
