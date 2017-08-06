json.extract! course, :id, :name, :semester, :year, :status, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
