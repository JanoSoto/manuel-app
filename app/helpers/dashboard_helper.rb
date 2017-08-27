module DashboardHelper
	def get_survey_path
		unless current_user.admin?
			return my_surveys_path
		else
			return surveys_path
		end
	end
end
