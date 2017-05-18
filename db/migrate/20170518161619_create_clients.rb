class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :clientRut
      t.string :clientName
      t.string :clientLastName
      t.string :clientEmail
      t.integer :clientCellPhone
      t.string :clientAddress

      t.timestamps null: false
    end
  end
end
