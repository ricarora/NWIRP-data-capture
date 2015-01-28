class ClientRelief < ActiveRecord::Base
  validates :client_id, numericality: { only_integer: true }
  validates :relief_name, :uniqueness => { scope: [:client_id]}
end
