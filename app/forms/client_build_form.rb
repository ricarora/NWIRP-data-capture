class ClientBuildForm
  include ActiveModel::Model

  def persisted?
    false
  end

  validates :first_name, :last_name, :gender, :a_number, :nationality, presence: true
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
  validates :represented, :drru_case, :inclusion => {:in => [true, false]}
  validates :nationality, :inclusion => {:in => Client::NATIONALITY}

  delegate :first_name, :last_name, :nationality, :ethnicity, :gender,
            :represented, :drru_case, :a_number, to: :client
  delegate :relief_name, to: :client_relief
  delegate :date, to: :assessment

  def client
    @client ||= Client.new
  end

  def submit(params)
    @relief_sought_array = []
    @client_relief_array = []
    client.last_name, client.first_name = params[:last_name], params[:first_name]
    client.nationality, client.ethnicity = params[:nationality], params[:ethnicity]
    client.gender = params[:gender]
    client.represented = params[:represented]
    client.drru_case = params[:drru_case]
    client.a_number = params[:a_number]
    unless params[:date].blank?
      assessment = client.assessments.build
      assessment.date = params[:date]
    end
    params[:relief_name].each do |value|
      if value != ""
        relief_sought = ReliefSought.where(name: value).first_or_initialize
        client_relief = client.client_reliefs.build(relief_name: relief_sought.name)
        @relief_sought_array << relief_sought
        @client_relief_array << client_relief
      end
    end
  end

  def objects_valid?
    # client.valid?
    # client.assessment.valid?
    # client.client_reliefs.valid?
    # @relief_sought_array.each do |relief_sought|
    #   relief_sought.valid?
    # end

    # if @client_relief.invalid?
    #   if @errors[:client_relief]
    #     @errors[:client_relief] += [@client_relief.errors]
    #   else
    #     @errors[:client_relief] = [@client_relief.errors]
    #   end
    # end
    true
  end

  def save
    client.save!
    @relief_sought_array.each do |relief_sought|
      relief_sought.save!
    end
  end
end
