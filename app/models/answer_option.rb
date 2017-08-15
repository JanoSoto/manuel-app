class AnswerOption < ActiveRecord::Base
  belongs_to :question

  has_many :survey_results
  has_many :questions, through: :survey_results
  has_many :assigned_surverys, through: :survey_results
end
