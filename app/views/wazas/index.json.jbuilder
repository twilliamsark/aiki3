json.array!(@wazas) do |waza|
  json.extract! waza, :id, :name, :stance, :attack, :attack_height, :hand_applied_to, :maka_komi, :technique, :direction, :kaiten, :sword, :level
  json.url waza_url(waza, format: :json)
end
