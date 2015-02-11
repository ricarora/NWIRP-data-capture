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
  # validate :validate_a_number_uniqueness
  validate :validate_ethnicity

  def validate_ethnicity
    ethnicity.each do |selection|
      if !ethnicity.is_a?(Array) || !Client::ETHNICITY.include?(selection)
        errors.add(:ethnicity, :invalid)
      end
    end
  end

  # def validate_a_number_uniqueness
  #   if Client.all.where(a_number: self.a_number)
  #     errors.add(:a_number, "A# already exists")
  #   end
  # end

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

    @client_relief_array = []
    client.last_name, client.first_name = params[:last_name].capitalize, params[:first_name].capitalize
    client.nationality = params[:nationality]
    client.ethnicity = params[:ethnicity].reject(&:empty?)
    client.gender = params[:gender]
    client.represented = params[:represented]
    client.drru_case = params[:drru_case]
    client.a_number = params[:a_number]
    assessment.date = params[:date]
    assessment.client = client
    params[:relief_name].uniq.each do |value|
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
