json.array!(@maka_komis) do |maka_komi|
  json.extract! maka_komi, :id, :name, :description
  json.url maka_komi_url(maka_komi, format: :json)
end
