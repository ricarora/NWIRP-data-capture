# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

json.array!(@convictions) do |conviction|
  json.extract! conviction, :id, :crime_name, :rcw, :subsection, :sentence, :ij_name, :nta_charges, :ij_decision_date, :ij_finding, :client_id, :notes
  json.url conviction_url(conviction, format: :json)
end
