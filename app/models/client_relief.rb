class ClientRelief < ActiveRecord::Base
  validates :client_id, numericality: { only_integer: true }
end
