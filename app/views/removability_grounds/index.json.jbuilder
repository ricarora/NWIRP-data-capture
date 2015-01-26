json.array!(@removability_grounds) do |removability_ground|
  json.extract! removability_ground, :id, :name
  json.url removability_ground_url(removability_ground, format: :json)
end
