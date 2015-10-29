json.array!(@senseis) do |sensei|
  json.extract! sensei, :id, :name
  json.url sensei_url(sensei, format: :json)
end
