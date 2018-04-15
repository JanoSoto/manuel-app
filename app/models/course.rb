class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_students
  has_many :users, through: :course_students
  has_many :assigned_surveys
  has_many :users, through: :assigned_surveys

  def sem_year
  	return self.semester.to_s+'/'+self.year.to_s
  end

	def can_create_survey?
		if self.course_students.empty?
			return false
		end
		
		students = self.course_students.where(group_name: nil)
		if students.empty?
			return true
		else
			count = 0
			students.each do |student|
				if student.assistant? or student.group_lead? or student.project_lead?
					count += 1
				end
			end
			return count == students.size
		end
	end
end
