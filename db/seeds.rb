# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

reliefs = ["10 YR", "AAOS", "AAOS 209C WAIVER", "AOS", "AOS 212H WAIVER",
  "AOS 245I", "ASY", "CAA", "CAT", "LPR", "NACARA", "RAOS", "RAOS 209C WAIVER",
  "SVISA", "TVISA", "UVISA", "VAWA CANCELLATION", "VAWA SELF PETITION", "WOR"]

reliefs.each do |relief_name|
  ReliefSought.create(name: relief_name)
end
