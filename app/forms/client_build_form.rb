class ClientBuildForm
  include ActiveModel::Model

  def persisted?
    false
  end

  validates :first_name, :last_name, :gender, :a_number, :nationality, presence: true
  validates :gender, inclusion: { in: %w(Male Female Transgender),
    message: "Only accepts Male, Female, or Transgender."}
  validates :represented, :drru_case, :inclusion => {:in => [true, false]}
  validates :nationality, :inclusion => {:in => Client::NATIONALITY}

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
    client.last_name, client.first_name = params[:last_name], params[:first_name]
    client.nationality, client.ethnicity = params[:nationality], params[:ethnicity]
    client.gender = params[:gender]
    client.represented = params[:represented]
    client.drru_case = params[:drru_case]
    client.a_number = params[:a_number]
    assessment.date = params[:date]

    if valid?
      client.save!
      if !assessment.date.nil?
        assessment.client = client
        assessment.save!
      end
      check_relief_sought(params)
      true
    else
      false
    end
  end

  def check_relief_sought(params)
    params[:relief_name].each do |value|
      if value != ""
        if ReliefSought.where(name: value).empty?
          new_relief = ReliefSought.create(name: value)
          add_client_relief(new_relief.name)
        else
          add_client_relief(ReliefSought.find(value).name)
        end
      end
    end
    return true
  end

  def add_client_relief(name)
    @client_relief = ClientRelief.new(relief_name: name)
    @client_relief.client = @client
    @client_relief.save
    if @client_relief.invalid?
      if @errors[:client_relief]
        @errors[:client_relief] += [@relief.errors]
      else
        @errors[:client_relief] = [@relief.errors]
      end
    end
  end
end
