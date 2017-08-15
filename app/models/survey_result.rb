class SurveyResult < ActiveRecord::Base
	belongs_to :assigned_survey
	belongs_to :question
	belongs_to :answer_option
end
