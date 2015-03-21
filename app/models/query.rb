# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class Query < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
