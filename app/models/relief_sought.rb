
# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class ReliefSought < ActiveRecord::Base
  has_many :clients, through: :client_reliefs
  has_many :client_reliefs
  self.primary_key = 'name'
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def self.order_reliefs
    self.all.sort_by {|a| a.name }
  end

end
