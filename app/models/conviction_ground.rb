class ConvictionGround < ActiveRecord::Base
  belongs_to :conviction
  belongs_to :removability_ground
  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Made"],
    message: "Only accepts Yes, No or Finding Not Made.", allow_blank: true}
  validates :gor_name, :uniqueness => { scope: :conviction_id}
  #validates :conviction, presence: true

  STATUS_OPTION = [["Yes", "Yes"], ["No", "No"], ["Finding Not Made", "Finding Not Made"]]
end
