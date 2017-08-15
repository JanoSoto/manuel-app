class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answer_options

  has_many :survey_results
  #has_many :answer_options, through: :survey_results
  has_many :assigned_surverys, through: :survey_results
end
