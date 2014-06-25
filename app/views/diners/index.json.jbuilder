json.array!(@diners) do |diner|
  json.extract! diner, :id, :name
  json.url diner_url(diner, format: :json)
end
