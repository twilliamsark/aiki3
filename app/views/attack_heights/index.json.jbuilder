json.array!(@attack_heights) do |attack_height|
  json.extract! attack_height, :id, :name, :description
  json.url attack_height_url(attack_height, format: :json)
end
