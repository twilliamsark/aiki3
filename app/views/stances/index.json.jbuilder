json.array!(@stances) do |stance|
  json.extract! stance, :id, :name, :description
  json.url stance_url(stance, format: :json)
end
