class ConvictionGround < ActiveRecord::Base
  belongs_to :conviction
  belongs_to :removability_ground
  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Made"],
    message: "Only accepts Yes, No or Finding Not Made.", allow_blank: true}
  validates :gor_name, :uniqueness => { scope: :conviction_id}
  #validates :conviction, presence: true

  STATUS_OPTION = [["Yes", "Yes"], ["No", "No"], ["Finding Not Made", "Finding Not Made"]]
  GROUNDS = RemovabilityGround.all.map {|ground| ground.name}

  GROUNDS.each do |ground|
    ransacker ground.to_sym do |parent|
      Arel::Nodes::InfixOperation.new('AND',
        Arel::Nodes::InfixOperation.new('||', parent.table[:gor_name].eq(ground), ' '),
        # Arel::Nodes::NamedFunction.new(:coalesce, [parent.table[:gor_name], ground]),
        parent.table[:status])
    end
  end


  def self.ransackable_attributes(auth_object = nil)
    %w() + _ransackers.keys
  end
end
