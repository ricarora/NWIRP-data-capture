class ConvictionBuildForm
  include ActiveModel::Model

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

  def submit(params)
    conviction_params = params.slice(:crime_name, :rcw, :subsection, :sentence)
    conviction.ij_name, conviction.nta_charges = params[:ij_name], params[:nta_charges]
    conviction.ij_decision_date, conviction.ij_finding = params[:ij_decision_date], params[:ij_finding]
    conviction.notes, conviction.client_id = params[:notes], params[:client_id]
    conviction.crime_name, conviction.rcw, convicton.subsection, conviction.sentence = conviction_params
    conviction_ground.gor_name, conviction_ground.status = params[:gor_name], params[:status]
    create_conviction_ground(params[:conviction_grounds])
    if valid?
      conviction.save!
      conviction_ground.save!
      true
    else
      false
    end
  end

  def create_conviction_ground(cg_params)
    cg_params.each do |name, value|
      conviction_ground.gor_name, conviction_ground.status = name, value
      if valid?
        conviction_ground.save!
        true
      else
        false
      end
    end
  end
end
