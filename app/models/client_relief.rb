class ClientRelief < ActiveRecord::Base
  belong_to :client
  belong_to :relief_sought
  validates :client_id, numericality: { only_integer: true }
  validates :relief_name, :uniqueness => { scope: [:client_id]}
end
