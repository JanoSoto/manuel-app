json.extract! pet, :id, :name, :genre, :race_id, :birthdate, :observations, :created_at, :updated_at
json.url pet_url(pet, format: :json)
