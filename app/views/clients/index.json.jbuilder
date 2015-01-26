json.array!(@clients) do |client|
  json.extract! client, :id, :last_name, :first_name, :nationality, :ethnicity, :gender, :relief_sought, :represented, :drru_case, :a_number
  json.url client_url(client, format: :json)
end
