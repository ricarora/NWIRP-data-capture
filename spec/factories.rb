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
    name "Assault 3"
    rcw "9a.36.031"
    sentence 365
    ij_name "Judge Fitting"
    nta_charges "212(a)(2)(A)(i)"
    ij_decision_date "2015-01-27"
    lj_finding "Vol Dept"
  end
end
