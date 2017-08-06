class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :semester, limit: 1
      t.integer :year, limit: 2
      t.boolean :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
