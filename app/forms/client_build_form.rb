class ClientBuildForm
  include ActiveModel::Model
  attr_reader :attributes, :client, :errors

  delegate :first_name, :last_name, :nationality, :ethnicity, :gender,
            :represented, :drru_case, :a_number, to: :client
  delegate :relief_name, to: :client_relief
  delegate :date, to: :assessment

  def client
    @client ||= Client.new
  end

  def client_relief
    @client_relief = ClientRelief.new
  end

  def assessment
    @assessment = Assessment.new
  end

  def initialize(attributes, client = nil)
    @attributes = attributes
    @client = client
    @assessment = nil
    @relief = nil
    @errors = {}
  end

  def create
    @client = Client.new(first_name: @attributes[:first_name],
                          last_name: @attributes[:last_name],
                          nationality: @attributes[:nationality],
                          ethnicity: @attributes[:ethnicity],
                          gender: @attributes[:gender],
                          represented: @attributes[:represented],
                          drru_case: @attributes[:drru_case],
                          a_number: @attributes[:a_number])
    if !@attributes[:assessment].empty?
      @assessment = Assessment.new(date: Date.parse(@attributes[:assessment]))
      @assessment.client = @client
    end
  end

  def save
    create
    if @client.valid?
      if @assessment
        if @assessment.valid?
          # let us save client_relief here
          @client.save
          @assessment.save
          create_client_relief
        else
          @assessment.save
          @errors[:client_assessment] = @assessment.errors
          return false
        end
      else
        @client.save
        create_client_relief
      end
    else
      @client.save
      @errors[:client] = @client.errors
      return false
    end
  end

  def create_client_relief
    @attributes[:relief_sought].each do |name|
      if ReliefSought.where(name: name).empty?
        new_relief = ReliefSought.create(name: name)
        add_client_relief(new_relief.name)
      else
        add_client_relief(ReliefSought.find(name).name)
      end
    end
    return true
  end

  def add_client_relief(name)
    @client_relief = ClientRelief.new(relief_name: name)
    @client_relief.client = @client
    @client_relief.save
    if @relief.invalid?
      if @errors[:client_relief]
        @errors[:client_relief] += [@relief.errors]
      else
        @errors[:client_relief] = [@relief.errors]
      end
    end
  end
end
