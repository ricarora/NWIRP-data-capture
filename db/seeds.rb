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

judge_name = ["Odell", "Scala", "Fitting"]
judge_name.each do |judge|
  Judge.where(name: judge).first_or_create
end

nwirp_admin = User.new
nwirp_admin.email = "bill@nwirp.org"
nwirp_admin.password = "12345678"
nwirp_admin.password_confirmation = "12345678"
nwirp_admin.toggle!(:approved)
nwirp_admin.name = "Bill"
nwirp_admin.toggle!(:admin)
nwirp_admin.save!
