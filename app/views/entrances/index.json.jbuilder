json.array!(@entrances) do |entrance|
  json.extract! entrance, :id, :name, :description
  json.url entrance_url(entrance, format: :json)
end
