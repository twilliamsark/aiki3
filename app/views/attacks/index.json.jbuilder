json.array!(@attacks) do |attack|
  json.extract! attack, :id, :name, :description
  json.url attack_url(attack, format: :json)
end
