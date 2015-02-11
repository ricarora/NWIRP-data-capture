class ClientBuildForm
  include ActiveModel::Model

  def persisted?
    false
  end

  validates :last_name, :a_number, :assessment, presence: true
  validates :a_number, format: { with: /\d{3}-\d{3}-\d{3}/,
    message: "Only allows numbers in this format: XXX-XXX-XXX." }
  validates :gender, inclusion: { in: %w(Male Female Other Unknown),
    message: "Only accepts Male, Female, Other, or Unknown.", allow_blank: true}
  validates :represented, inclusion: { in: %w(Yes No Unknown),
    message: "Only accepts Yes, No, or Unknown.", allow_blank: true}
  validates :drru_case, :inclusion => {in: [true, false], allow_blank: true}
  validates :nationality, :inclusion => {in: Client::NATIONALITY, allow_blank: true}
  validates :ethnicity, :inclusion => {in: Client::ETHNICITY, allow_blank: true}

  delegate :first_name, :last_name, :nationality, :ethnicity, :gender,
            :represented, :drru_case, :a_number, to: :client
  delegate :relief_name, to: :client_relief
  delegate :date, to: :assessment

  def client
    @client ||= Client.new
  end

  def assessment
    @assessment ||= client.assessments.build
  end

  def submit(params)
    raise
    @client_relief_array = []
    client.last_name, client.first_name = params[:last_name].capitalize, params[:first_name].capitalize
    client.nationality, client.ethnicity = params[:nationality], params[:ethnicity]
    client.gender = params[:gender]
    client.represented = params[:represented]
    client.drru_case = params[:drru_case]
    client.a_number = params[:a_number]
    assessment.date = params[:date]
    assessment.client = client
    params[:relief_name].each do |value|
      unless value.empty?
        client_relief = client.client_reliefs.build(relief_name: value)
        @client_relief_array << client_relief
      end
    end
    true
  end

  def all_valid?
    valid?
  end

  def save
    client.save!
  end
end
