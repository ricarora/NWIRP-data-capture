class ClientBuildForm
  include ActiveModel::Model
  # attr_reader :attributes, :client, :errors

  def persisted?
    false
  end

  validates :first_name, :last_name, :gender, :a_number, :nationality, presence: true
  
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
  validates :represented, :drru_case, :inclusion => {:in => [true, false]}

  delegate :first_name, :last_name, :nationality, :ethnicity, :gender,
            :represented, :drru_case, :a_number, to: :client
  delegate :relief_name, to: :client_relief
  delegate :date, to: :assessment

  def client
    @client ||= Client.new
  end

  def client_relief
    @client_relief ||= ClientRelief.new(client_id: @client.id)
  end

  def assessment
    @assessment ||= Assessment.new(client_id: @client.id)
  end

  def submit(params)
    client_params = params.slice(:gender, :represented, :drru_case, :a_number)
    client.last_name, client.first_name = params[:last_name], params[:first_name]
    client.nationality, client.ethnicity = params[:nationality], params[:ethnicity]
    client.gender, client.represented, client.drru_case, client.a_number = client_params
    assessment.date = params[:date]

    if valid?
      client.save!
      assessment.save!
      check_relief_sought
      true
    else
      false
    end
  end

  # def initialize(attributes, client = nil)
  #   @attributes = attributes
  #   @client = client
  #   @assessment = nil
  #   @relief = nil
  #   @errors = {}
  # end

  # def create
  #   @client.first_name = @attributes[:first_name]
  #   @client.last_name = @attributes[:last_name]
  #   @client.nationality = @attributes[:nationality]
  #   @client.ethnicity = @attributes[:ethnicity]
  #   @client.gender = @attributes[:gender]
  #   @client.represented = @attributes[:represented]
  #   @client.drru_case = @attributes[:drru_case]
  #   @client.a_number = @attributes[:a_number]
  #   if !@attributes[:assessment].empty?
  #     @assessment = Assessment.new(date: Date.parse(@attributes[:assessment]))
  #     @assessment.client = @client
  #   end
  # end
  #
  # def save
  #   create
  #   if @client.valid?
  #     if @assessment
  #       if @assessment.valid?
  #         # let us save client_relief here
  #         @client.save
  #         @assessment.save
  #         create_client_relief
  #       else
  #         @assessment.save
  #         @errors[:client_assessment] = @assessment.errors
  #         return false
  #       end
  #     else
  #       @client.save
  #       create_client_relief
  #     end
  #   else
  #     @client.save
  #     @errors[:client] = @client.errors
  #     return false
  #   end
  # end

  def check_relief_sought
    params[:client_build_form].slice(:relief_name).each do |name|
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
