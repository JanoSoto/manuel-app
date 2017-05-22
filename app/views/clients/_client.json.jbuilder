json.extract! client, :id, :clientRut, :clientName, :clientLastName, :clientEmail, :clientCellPhone, :clientAddress, :created_at, :updated_at
json.url client_url(client, format: :json)
