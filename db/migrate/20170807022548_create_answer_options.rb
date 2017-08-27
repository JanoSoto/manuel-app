class CreateAnswerOptions < ActiveRecord::Migration
  def change
    create_table :answer_options do |t|
      t.string :answer
      t.integer :score, limit: 2
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
