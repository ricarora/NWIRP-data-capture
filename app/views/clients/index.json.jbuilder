# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

json.array!(@clients) do |client|
  json.extract! client, :id, :last_name, :first_name, :nationality, :ethnicity, :gender, :client_reliefs, :represented, :drru_case, :a_number
  json.url client_url(client, format: :json)
end
