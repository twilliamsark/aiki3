json.array!(@swords) do |sword|
  json.extract! sword, :id, :name, :description
  json.url sword_url(sword, format: :json)
end
