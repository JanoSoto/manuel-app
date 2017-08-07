json.extract! question, :id, :statement, :hint, :score, :survey_id, :created_at, :updated_at
json.url question_url(question, format: :json)
