json.extract! payment, :id, :description, :amount, :pay_date, :verified, :created_at, :updated_at
json.url payment_url(payment, format: :json)
