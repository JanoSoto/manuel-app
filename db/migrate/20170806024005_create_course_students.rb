class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|

      t.timestamps null: false
    end
  end
end
