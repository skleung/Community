json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :name, :cost, :finished
  json.url ingredient_url(ingredient, format: :json)
end
