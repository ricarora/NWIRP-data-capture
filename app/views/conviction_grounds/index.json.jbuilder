json.array!(@conviction_grounds) do |conviction_ground|
  json.extract! conviction_ground, :id, :gor_name, :conviction_id, :status
  json.url conviction_ground_url(conviction_ground, format: :json)
end
