json.array!(@videos) do |video|
  json.extract! video, :id, :name, :waza_id, :aiki_format_id, :rank_id, :on_test, :youtube_id
  json.url video_url(video, format: :json)
end
