module ApplicationHelper
	def get_pending_surveys
    if user_signed_in? and current_user.student?
      return AssignedSurvey.where(user_id: current_user.id, answered: false).count
    else
      return 0
    end
  end
end
