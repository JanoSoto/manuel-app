class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  def admin?
  	return self.roles_id == 1
  end

  def receptionist?
  	return self.roles_id == 2
  end

  def user_name
    if !self.name.nil? && !self.lastname.nil?
      user_name =  self.name + " " + self.lastname
    else
      user_name = self.email
    end
    user_name
  end

  def created_at
    if !attributes['created_at'].nil?
        attributes['created_at'].strftime("%m/%d/%Y %H:%M:%S")
    end
  end

  def role
    if self.roles_id == 1
      role = "Administrador"
    else
      role = "Recepcionista"
    end
  end
end
