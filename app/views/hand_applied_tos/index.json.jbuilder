json.array!(@hand_applied_tos) do |hand_applied_to|
  json.extract! hand_applied_to, :id, :name, :description
  json.url hand_applied_to_url(hand_applied_to, format: :json)
end
