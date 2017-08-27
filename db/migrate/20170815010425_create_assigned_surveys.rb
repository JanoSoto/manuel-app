class CreateAssignedSurveys < ActiveRecord::Migration
  def change
    create_table :assigned_surveys do |t|
      t.string :name
      t.boolean :answered
      t.integer :user_id
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
