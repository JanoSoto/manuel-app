class AddReferencesToSurveyResults < ActiveRecord::Migration
  def change
  	remove_column :survey_results, :assigned_survey_id
  	remove_column :survey_results, :question_id
  	remove_column :survey_results, :answer_option_id

  	add_reference :survey_results, :assigned_survey, index: true, foreign_key: true
  	add_reference :survey_results, :answer_option, index: true, foreign_key: true
  end
end
