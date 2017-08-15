class AddReferencesToAssignedSurvey < ActiveRecord::Migration
  def change
  	remove_column :assigned_surveys, :user_id
  	add_reference :assigned_surveys, :user, index: true, foreign_key: true
  	remove_column :assigned_surveys, :course_id
  	add_reference :assigned_surveys, :course, index: true, foreign_key: true
  	add_reference :assigned_surveys, :survey, index: true, foreign_key: true
  end
end
