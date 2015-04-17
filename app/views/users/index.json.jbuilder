json.array!(@users) do |user|
  json.extract! user, :id, :name, :msg
  json.url user_url(user, format: :json)
end
