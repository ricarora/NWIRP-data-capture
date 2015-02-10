class ConvictionGround < ActiveRecord::Base
  belongs_to :conviction
  belongs_to :removability_ground
  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Found"],
    message: "Only accepts Yes, No or Finding Not Found.", allow_blank: true}
  validates :gor_name, :uniqueness => { scope: :conviction_id}
  #validates :conviction, presence: true

  STATUS_OPTION = [["Yes", "Yes"], ["No", "No"], ["Finding Not Found", "Finding Not Found"]]
end
