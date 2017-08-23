class AssignedSurvey < ActiveRecord::Base
	belongs_to :course
	belongs_to :user
	belongs_to :survey
	belongs_to :evaluated_user, class_name: "User"
end
