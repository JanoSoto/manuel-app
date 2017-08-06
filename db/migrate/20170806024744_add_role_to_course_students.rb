class AddRoleToCourseStudents < ActiveRecord::Migration
  def change
  	add_column :course_students, :role, :string
  end
end
