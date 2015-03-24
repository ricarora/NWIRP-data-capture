# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

reliefs_sought = ["212C; WAIVER IN RMV PROCEED. PERMITTED BY CASE LAW",
  "245 - ADJUSTMENT OF STATUS", "ASYLUM", "ASYLUM -WITHHOLDING", "CHILD",
  "CITIZENSHIP", "COERCIVE POPULATION CONTROL", "DACA", "DAPA",
  "EOIR 40 FOR NACARA ELIGIBLES IN REMOVAL PROCS", "EOIR42A", "EOIR42B",
  "EOIR42B - 10YR CANCELLATION", "EOIR42B - 3YR CANCELLATION", "HRFA - ASYLUM",
  "HRFA - CHILD ABANDONED", "HRFA - CHILD ORPHANED", "HRFA - CHILD WITHOUT PARENTS",
  "HRFA - PAROLE", "HRFA - SPOUSE", "HRFA - UNMARRIED SON OR DAUGHTER",
  "NACARA ADJUSTMENT", "NO RELIEF", "OTHER", "PRIMA FACIE",
  "PROSECUTORIAL DISCRETION","REGISTRY-ADJUSTMENT OF STATUS. ENTRY BEFORE 1/1/72",
  "REQUEST FOR A MEDICAL WAIVER", "REQUEST FOR A WAIVER BY NONIMMIGRANT",
  "REQUEST FOR REMOVAL OF CONDITIONAL BASIS OF L.P.R.", "S VISA", "SIJ",
  "SUPPRESSION", "SUSPENSION/CANCELLATION UNDER NACARA", "T VISA", "TPS", "U VISA",
  "UNKNOWN", "VOLUNTARY DEPARTURE", "WAIVER", "WAIVER FOR A L.P.R. FOR ALIEN SMUGGLING",
  "WAIVER OF 212(A)(7)(B)(I) DOC. REQUIREMENTS- GUAM","WAIVER OF DEFECTIVE VISA OR LABOR CERTIFICATE",
  "WAIVER OF DEPORTABILITY- FULL PARDON 241 (A)(2)(A) 38","WAIVER OF INADMISSIBILITY OF A REFUGEE",
  "WAIVER OF PRIOR CRIM. CONDUCT (ADMISSION-ADJUST)", "WAIVER OF PRIOR VISA FR"]

reliefs_sought.each do |relief|
  ReliefSought.where(name: relief).first_or_create
end

grounds_of_removabilities = ["AGGRAVATED FELONY", "CIMT?", "PSC - ASYLUM?",
  "PSC - WITHHOLDING?", "VIOLENT/DANGEROUS", "FIREARM OFFENSE?"]

grounds_of_removabilities.each do |ground|
  RemovabilityGround.where(name: ground).first_or_create
end

User.create(email: "bill@nwirp.org", password: "Bill@NWIRP1", password_confirmation: "Bill@NWIRP1", approved: true, name: "Bill", admin: true)

judge_name = ["Odell", "Scala", "Fitting"]
judge_name.each do |judge|
  Judge.where(name: judge).first_or_create
end

(1..10).each do
  client = {
    a_number: "#{Faker::Number.number(3)}-#{Faker::Number.number(3)}-#{Faker::Number.number(3)}",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nationality: Client::NATIONALITY.sample,
    ethnicity: Client::ETHNICITY.sample,
    gender: Client::GENDER.sample,
    represented: Client::REPRESENTED.sample,
    drru_case: [true, false].sample,
  }
  c = Client.new(client)
  c.assessments = [Assessment.new(date: Faker::Date.between(100.days.ago, Date.today))]
  c.client_reliefs = [ClientRelief.new(relief_name: reliefs_sought.sample)]
  c.save
  c.convictions = []
  (1..[3,4].sample).each do
    conviction = {
      crime_name: ["Assault/Battery", "Aiding & Abetting / Accessory", "Drug Possession", "Burglary", "Theft / Larceny", "Forgery", "Homicide", "Shoplifting"].sample,
      rcw: "9a.#{Faker::Number.number(2)}.#{Faker::Number.number(3)}",
      subsection: "Subsection #{Faker::Number.digit}",
      sentence: Faker::Number.number(3),
      ij_name: Conviction::IJ_NAME.sample,
      nta_charges: "NTA Charge #{Faker::Number.digit}",
      ij_decision_date: Faker::Date.between(100.days.ago, Date.today),
      ij_finding: Faker::Lorem.sentence(3, true, 4),
      notes: [true, false].sample ? Faker::Lorem.paragraph : "",
      state_committed: Conviction::STATE_COMMITTED.sample,
      dv_on_roc: [true, false].sample,
    }
    c.convictions.append([Conviction.new(conviction)])
    con = c.convictions[-1]
    con.conviction_grounds = []
    grounds_of_removabilities.each do |ground|
      con.conviction_grounds.append(ConvictionGround.new(gor_name: ground, status: ["Yes", "No", "Finding Not Made"].sample))
    end
    con.save
  end
end
