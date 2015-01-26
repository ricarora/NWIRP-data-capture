json.array!(@grounds_for_removabilities) do |grounds_for_removability|
  json.extract! grounds_for_removability, :id, :name
  json.url grounds_for_removability_url(grounds_for_removability, format: :json)
end
