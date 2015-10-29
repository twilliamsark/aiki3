json.array!(@katas) do |kata|
  json.extract! kata, :id, :name
  json.url kata_url(kata, format: :json)
end
