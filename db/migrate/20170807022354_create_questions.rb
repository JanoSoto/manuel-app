class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :hint
      t.integer :score, limit: 2
      t.references :survey, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
