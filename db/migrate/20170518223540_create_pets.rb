class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :genre
      t.references :race, index: true, foreign_key: true
      t.date :birthdate
      t.text :observations

      t.timestamps null: false
    end
  end
end
