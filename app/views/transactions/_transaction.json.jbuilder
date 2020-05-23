json.extract! transaction, :id, :user_id, :account_id, :operation, :value, :account_whither, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
