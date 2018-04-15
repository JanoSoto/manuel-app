module CoursesHelper
	def get_role_class(role)
		case role
			when ''
				return 'btn-default'
			when nil
				return 'btn-default'
			when 'ayudante'
				return 'btn-primary'
			when 'jefe de grupo'
				return 'btn-success'
			when 'jefe de proyecto'
				return 'btn-warning'
		end
	end

	def new_survey_disabled(course)
		if course.can_create_survey?
			return ''
		else
			return 'disabled'
		end
	end
end
