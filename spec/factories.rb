FactoryGirl.define do
  factory :client do
    first_name "Miguel"
    last_name  "Contreras"
    a_number "1234567"
    nationality "Mexican"
    gender "Male"
    represented true
  end

  factory :conviction do
    crime_name "Assault 3"
    rcw "9a.36.031"
    sentence 365
    ij_name "Judge Fitting"
    nta_charges "212(a)(2)(A)(i)"
    ij_decision_date Date.parse("2015-01-27")
    ij_finding "Vol Dept"
  end
end
