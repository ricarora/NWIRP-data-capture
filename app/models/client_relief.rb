class ClientRelief < ActiveRecord::Base
  belongs_to :client
  belongs_to :relief_sought
  validates :relief_name, :uniqueness => { scope: [:client_id]}

  def self.ransackable_attributes(auth_object = nil)
    %w(relief_name) + _ransackers.keys
  end
end
