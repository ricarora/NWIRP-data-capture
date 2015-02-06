class ConvictionBuildForm
  include ActiveModel::Model
# passed like this: {"crime_name"=>"Go Fun", "rcw"=>"", "subsection"=>"",
# "sentence"=>"49", "ij_name"=>"", "nta_charges"=>"", "ij_decision_date"=>"",
# "ij_finding"=>"", "grounds"=>{"DV"=>"Yes", "Aggrevate felon"=>"No"}, "notes"=>""}
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
    message: "Only accepts Yes, No or Finding Not Found."}, on: :create

  delegate :crime_name, :rcw, :subsection, :sentence, :ij_name, :nta_charges,
            :ij_decision_date, :ij_finding, :client_id, :notes, to: :conviction
  delegate :gor_name, :conviction_id, :status, to: :conviction_ground

  def conviction
    @conviction ||= Conviction.new
  end

  def conviction_ground
    @conviction_ground = ConvictionGround.new(conviction_id: @conviction.id)
  end

  def submit(params, client_id)
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
    grounds = params[:conviction_grounds]
    if valid? && create_conviction_ground(grounds)
      conviction.save!
      save_conviction_ground(grounds)
      true
    else
      false
    end
  end

  def create_conviction_ground(grounds)
    check_array = []
    grounds.each do |name, status|
      conviction_ground
      @conviction_ground.gor_name, @conviction_ground.status = name, status
      if ["Yes", "No", "Finding Not Found"].include?(@conviction_ground.status)
        check_array << true
      else
        check_array << false
      end
    end
    if check_array.include?(false)
      return false
    else
      return true
    end
  end

  def save_conviction_ground(grounds)
    grounds.each do |name, status|
      conviction_ground
      @conviction_ground.gor_name, @conviction_ground.status = name, status
      @conviction_ground.save!
    end
  end
end
