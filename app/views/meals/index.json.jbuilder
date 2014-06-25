json.array!(@meals) do |meal|
  json.extract! meal, :id, :chef, :date
  json.url meal_url(meal, format: :json)
end
