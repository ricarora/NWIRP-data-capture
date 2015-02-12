class ClientRelief < ActiveRecord::Base
  belongs_to :client
  belongs_to :relief_sought
  validates :relief_name, :uniqueness => { scope: [:client_id]}
end
