class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_students
  has_many :users, through: :course_students
  has_many :assigned_surveys
  has_many :users, through: :assigned_surveys

  def sem_year
  	return self.semester.to_s+'/'+self.year.to_s
  end
end
