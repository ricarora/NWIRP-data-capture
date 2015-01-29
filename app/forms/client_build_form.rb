class ClientBuildForm
attr_reader :client

  def initialize(attributes, client = nil)
    @attributes = attributes
    @client = client
  end

  def save
    @client = Client.create(first_name: @attributes[:first_name],
                            last_name: @attributes[:last_name],
                            nationality: @attributes[:nationality],
                            ethnicity: @attributes[:ethnicity],
                            gender: @attributes[:gender],
                            represented: @attributes[:represented],
                            drru_case: @attributes[:drru_case],
                            a_number: @attributes[:a_number])
    @attributes[:relief_sought].each do |name|
      if name_found = ReliefSought.find(name)
        ClientRelief.create(relief_name: name_found.name,
                            client_id: @client.id)
      else
        add_relief(name)
      end
    end
    Assessment.create(date: @attributes[:assessment], client_id: @client.id)
  end

  def add_relief(name)
    new_relief = ReliefSought.create(name: name)
    ClientRelief.create(relief_name: new_relief.name, client_id: @client.id)
  end
end
