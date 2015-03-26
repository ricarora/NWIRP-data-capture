# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class RemovabilityGround < ActiveRecord::Base
  has_many :convictions, through: :conviction_grounds
  has_many :conviction_grounds
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.grounds_arr
    RemovabilityGround.all.map {|ground| ground.name}
  end
end
