class AddGroupNameToCourseStudent < ActiveRecord::Migration
  def change
  	add_column :course_students, :group_name, :string
  end
end
