json.array!(@kaitens) do |kaiten|
  json.extract! kaiten, :id, :name, :description
  json.url kaiten_url(kaiten, format: :json)
end
