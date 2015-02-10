class ClientBuildForm
  include ActiveModel::Model

  def persisted?
    false
  end

  validates :last_name, :a_number, :assessment, presence: true
  validates :a_number, format: { with: /\d{3}-\d{3}-\d{3}/,
    message: "Only allows numbers in this format: XXX-XXX-XXX." }
  validates :gender, inclusion: { in: %w(Male Female Other Unknown),
    message: "Only accepts Male, Female, Other, or Unknown."}
  validates :represented, inclusion: { in: %w(Yes No Unknown),
    message: "Only accespts Yes, No, or Unknown."}
  validates :drru_case, :inclusion => {:in => [true, false]}
  validates :nationality, :inclusion => {:in => Client::NATIONALITY}
  validates :nationality, :inclusion => {:in => Client::ETHNICITY}


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
    #@relief_sought_array = []
    @client_relief_array = []
    client.last_name, client.first_name = params[:last_name], params[:first_name]
    client.nationality, client.ethnicity = params[:nationality], params[:ethnicity]
    client.gender = params[:gender]
    client.represented = params[:represented]
    client.drru_case = params[:drru_case]
    client.a_number = params[:a_number]
    unless params[:date].blank?
      assessment.client = client
      assessment.date = params[:date]
    end
    params[:relief_name].each do |value|
      unless value.empty?
        #relief_sought = ReliefSought.where(name: value).first_or_initialize
        client_relief = client.client_reliefs.build(relief_name: relief_sought.name)
        #@relief_sought_array << relief_sought
        @client_relief_array << client_relief
      end
    end
    true
  end

  def client_relief_valid?
    if @client_relief_array.empty?
      true
    else
      @client_relief_array.each do |client_relief|
        if client_relief.valid?
          true
        else
          @errors[:client_relief] += [@client_relief.errors]
        end
      end
    end
  end

  # def relief_sought_valid?
  #   unless @relief_sought_array.empty?
  #     @relief_sought_array.each do |relief_sought|
  #       relief_sought.valid?
  #     end
  #   end
  #   true
  # end

  def assessment_valid?
    assessment.date.blank? ? true : assessment.valid?
  end

  def all_valid?
    valid?
  end

  def save
    client.save!
    # @relief_sought_array.each do |relief_sought|
    #   relief_sought.save!
    # end
  end
end
