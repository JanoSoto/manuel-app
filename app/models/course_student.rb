class CourseStudent < ActiveRecord::Base
	belongs_to :user
	belongs_to :course

	def assistant?
		return self.role == 'ayudante'
	end

	def group_lead?
		return self.role == 'jefe de grupo'
	end

	def project_lead?
		return self.role == 'jefe de proyecto'
	end
end
