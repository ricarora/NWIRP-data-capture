class ConvictionBuildForm
  include ActiveModel::Model

  def initialize
    @conviction_removability_grounds
  end

  def persisted?
    false
  end

  validates :crime_name, :sentence, presence: true
  validates :sentence, numericality: { only_integer: true }
  validates :ij_decision_date, presence:true, allow_blank: true
  validate :ij_decision_date_is_date?,
           :ij_decision_date_cannot_be_in_the_future

  def ij_decision_date_is_date?
    if ij_decision_date.present? && !ij_decision_date.respond_to?(:strftime)
      errors.add(:ij_decision_date, "must be a valid date")
    end
  end

  def ij_decision_date_cannot_be_in_the_future
    if ij_decision_date.present? && ij_decision_date > Date.today
      errors.add(:ij_decision_date, "can't be in the future")
    end
  end

  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Found"],
    message: "Only accepts Yes, No or Finding Not Found."}

  delegate :crime_name, :rcw, :subsection, :sentence, :ij_name, :nta_charges,
            :ij_decision_date, :ij_finding, :client_id, :notes, to: :conviction
  delegate :gor_name, :conviction_id, :status, to: :conviction_ground

  def conviction
    @conviction ||= Conviction.new
  end

  def conviction_ground
    @conviction_ground ||= ConvictionGround.new(conviction_id: @conviction.id)
  end

  def submit(params, client_id)
    # {
    #   crime_name: '',
    #   grounds: [ # one array member for each ground
    #     name: [
    #       'status'
    #     ]
    #     { name: '', status: ''},
    #     { name: '', status: ''},
    #     { name: '', status: ''}
    #   ]
    # }


    conviction.crime_name = params[:crime_name]
    conviction.rcw = params[:rcw]
    conviction.subsection = params[:subsection]
    conviction.sentence = params[:sentence]
    conviction.ij_name = params[:ij_name]
    conviction.nta_charges = params[:nta_charges]
    conviction.ij_decision_date = params[:ij_decision_date]
    conviction.ij_finding = params[:ij_finding]
    conviction.notes = params[:notes]
    conviction.client = Client.find(client_id)
    grounds = params[:grounds]
    create_conviction_ground(grounds)
    if valid?
      conviction.save!
      save_conviction_ground(grounds)
      true
    else
      false
    end
  end

  def create_conviction_ground(grounds)
    grounds.each do |name, status|
      conviction_ground.gor_name, conviction_ground.status = name, status
    end
  end

  def save_conviction_ground(grounds)
    grounds.each do |name, status|
      conviction_ground.gor_name, conviction_ground.status, conviction_ground.conviction_id = name, status, @conviction.id
      conviction_ground.save!
    end
  end
end
