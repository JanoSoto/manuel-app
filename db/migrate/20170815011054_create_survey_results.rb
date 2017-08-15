class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
    	t.integer :assigned_survey_id
    	t.integer :question_id
    	t.integer :answer_option_id

      t.timestamps null: false
    end
  end
end
