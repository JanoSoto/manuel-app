class AddColumnToCourseStudent < ActiveRecord::Migration
  def change
  	add_column :course_students, :course_id, :integer
  	add_column :course_students, :user_id, :integer
  end
end
