class ClientBuildForm

  attr_reader :attributes, :client, :errors

  def initialize(attributes, client = nil)
    @attributes = attributes
    @client = client
    @assessment = assessment
    @relief = relief
    @errors = {}
  end

  def save
    @client = Client.new(first_name: @attributes[:first_name],
                          last_name: @attributes[:last_name],
                          nationality: @attributes[:nationality],
                          ethnicity: @attributes[:ethnicity],
                          gender: @attributes[:gender],
                          represented: @attributes[:represented],
                          drru_case: @attributes[:drru_case],
                          a_number: @attributes[:a_number])
    @client.valid?

    if !@attributes[:assessment].empty?
      @assessment = Assessment.new(date: Date.parse(@attributes[:assessment]))
      @assessment.client = @client
    end
    @assessment.valid?

    @attributes[:relief_sought].each do |name|
      if ReliefSought.where(name: name).empty?
        new_relief = ReliefSought.create(name: name)
        add_client_relief(new_relief.name)
      else
        add_client_relief(ReliefSought.find(name).name)
      end
    end
  end

  def add_client_relief(name)
    @relief = ClientRelief.new(relief_name: name)
    @relief.client = @client
    @relief.valid?
  end


    if @client.errors.any?
      @errors[:client]=@client.errors
    end

    if !@client.id.nil?
      @attributes[:relief_sought].each do |name|
        if ReliefSought.where(name: name).empty?
          new_relief = ReliefSought.create(name: name)
          add_client_relief(new_relief.name)
        else
          add_client_relief(ReliefSought.find(name).name)
        end
      end
    end

    if !@attributes[:assessment].empty?
      client_assessment = Assessment.create(date: Date.parse(@attributes[:assessment]), client_id: @client.id)
      client_errors(client_assessment, :client_assessment)
    end
    @client.valid?
  end

  def add_client_relief(name)
    relief = ClientRelief.new(relief_name: name, client_id: @client.id)
    client_errors(relief, :client_relief)
  end

  def client_errors(name, name_sym)
    if name.errors.any?
      if @errors[name_sym]
        @errors[name_sym] += [name.errors]
      else
        @errors[name_sym] = [name.errors]
      end
    end
  end

  def is_valid?
    @client.valid?
  end
end
