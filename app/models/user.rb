class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  has_many :course_students
  has_many :courses, through: :course_students
  has_many :assigned_surveys
  has_many :courses, through: :assigned_surveys

  def admin?
  	return self.roles_id == 1
  end

  def teacher?
  	return self.roles_id == 2
  end

  def student?
    return self.roles_id == 3
  end

  def full_name
    if !self.name.nil? && !self.lastname.nil?
      return self.name.capitalize + " " + self.lastname.capitalize
    else
      return self.email
    end
  end

  def created_at
    if !attributes['created_at'].nil?
        attributes['created_at'].strftime("%m/%d/%Y %H:%M:%S")
    end
  end

  def role
    case self.roles_id
      when 1
        return 'Administrador'
      when 2
        return 'Profesor'
      when 3
        return 'Estudiante'
    end
  end

  def project_leader?(course_id)
    return CourseStudent.find_by(user_id: self.id, course_id: course_id).try(:role) == 'jefe de proyecto'
  end

  def group_leader?(course_id)
    return CourseStudent.find_by(user_id: self.id, course_id: course_id).try(:role) == 'jefe de grupo'
  end
end
