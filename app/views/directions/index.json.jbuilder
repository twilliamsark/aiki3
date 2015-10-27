json.array!(@directions) do |direction|
  json.extract! direction, :id, :name, :description
  json.url direction_url(direction, format: :json)
end
