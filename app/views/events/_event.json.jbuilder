json.extract! event, :id, :name, :user_id, :type, :time, :created_at, :updated_at
json.url event_url(event, format: :json)
