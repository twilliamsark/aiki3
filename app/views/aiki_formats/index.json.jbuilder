json.array!(@aiki_formats) do |aiki_format|
  json.extract! aiki_format, :id, :name, :description
  json.url aiki_format_url(aiki_format, format: :json)
end
