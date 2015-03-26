# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class Judge < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.judge_arr
    Judge.all.map {|j| j.name}
  end
end
