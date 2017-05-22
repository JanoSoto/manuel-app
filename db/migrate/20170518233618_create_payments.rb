class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :description
      t.integer :amount
      t.date :pay_date
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
