json.extract! account, :id, :user_id, :account_number, :balance, :created_at, :updated_at
json.url account_url(account, format: :json)
