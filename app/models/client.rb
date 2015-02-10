class Client < ActiveRecord::Base
  has_many :assessments, autosave: true
  has_many :convictions
  has_many :relief_soughts, through: :client_reliefs
  has_many :client_reliefs, autosave: true
  validates_uniqueness_of :a_number
  validates :last_name, :a_number, :assessment, presence: true
  validates :a_number, format: { with: /\d{3}-\d{3}-\d{3}/,
    message: "Only allows numbers in this format: XXX-XXX-XXX." }
  validates :gender, inclusion: { in: %w(Male Female Other Unknown),
    message: "Only accepts Male, Female, Other, or Unknown.", allow_blank: true}
  validates :drru_case, inclusion: {in: [true, false], allow_blank: true}
  validates :represented, inclusion: { in: %w(Yes No Unknown),
    message: "Only accepts Yes, No, or Unknown.", allow_blank: true}


  GENDER = ["Male", "Female", "Other", "Unknown"]

  REPRESENTED = ["Yes", "No", "Unkown"]

  NATIONALITY = ["Afghan", "Albanian", "Algerian", "American", "Andorran",
                "Angolan", "Antiguans", "Argentinean", "Armenian", "Australian",
                "Austrian", "Azerbaijani", "Bahamian", "Bahraini", "Bangladeshi",
                "Barbadian", "Barbudans", "Batswana", "Belarusian", "Belgian",
                "Belizean", "Beninese", "Bhutanese", "Bolivian", "Bosnian",
                "Brazilian", "British", "Bruneian", "Bulgarian", "Burkinabe",
                "Burmese", "Burundian", "Cambodian", "Cameroonian", "Canadian",
                "Cape Verdean", "Central", "African", "Chadian", "Chilean",
                "Chinese", "Colombian", "Comoran", "Congolese", "Costa Rican",
                "Croatian", "Cuban", "Cypriot", "Czech", "Danish", "Djibouti",
                "Dominican", "Dutch", "East Timorese", "Ecuadorean", "Egyptian",
                "Emirian", "Equatorial", "Guinean", "Eritrean", "Estonian",
                "Ethiopian", "Fijian", "Filipino", "Finnish", "French",
                "Gabonese", "Gambian", "Georgian", "German", "Ghanaian",
                "Greek", "Grenadian", "Guatemalan", "Guinea-Bissauan", "Guinean",
                "Guyanese", "Haitian", "Herzegovinian", "Honduran", "Hungarian",
                "Icelander", "Indian", "Indonesian", "Iranian", "Iraqi", "Irish",
                "Israeli", "Italian", "Ivorian", "Jamaican", "Japanese", "Jordanian",
                "Kazakhstani", "Kenyan", "Kittian", "and", "Nevisian", "Kuwaiti",
                "Kyrgyz", "Laotian", "Latvian", "Lebanese", "Liberian", "Libyan",
                "Liechtensteiner", "Lithuanian", "Luxembourger", "Macedonian",
                "Malagasy", "Malawian", "Malaysian", "Maldivan", "Malian",
                "Maltese", "Marshallese", "Mauritanian", "Mauritian", "Mexican",
                "Micronesian", "Moldovan", "Monacan", "Mongolian", "Moroccan",
                "Mosotho", "Motswana", "Mozambican", "Namibian", "Nauruan", "Nepalese",
                "Netherlander", "New Zealander", "Ni-Vanuatu", "Nicaraguan",
                "Nigerian", "Nigerien", "North", "Korean", "Northern", "Irish",
                "Norwegian", "Omani", "Pakistani", "Palauan", "Panamanian",
                "Papua New Guinean", "Paraguayan", "Peruvian", "Polish",
                "Portuguese", "Qatari", "Romanian", "Russian", "Rwandan",
                "Saint Lucian", "Salvadoran", "Samoan", "San Marinese",
                "Sao Tomean", "Saudi", "Scottish", "Senegalese", "Serbian",
                "Seychellois", "Sierra", "Leonean", "Singaporean", "Slovakian",
                "Slovenian", "Solomon", "Islander", "Somali", "South African",
                "South Korean", "Spanish", "Sri Lankan", "Sudanese", "Surinamer",
                "Swazi", "Swedish", "Swiss", "Syrian", "Taiwanese", "Tajik",
                "Tanzanian", "Thai", "Togolese", "Tongan", "Trinidadian",
                "Tobagonian", "Tunisian", "Turkish", "Tuvaluan", "Ugandan",
                "Ukrainian", "Uruguayan", "Uzbekistani", "Venezuelan",
                "Vietnamese", "Welsh", "Yemenite", "Zambian", "Zimbabwean", "Unknown"]

  ETHNICITY = ["Native American or Alaska Native", "Asian – not Pacific Islander",
              "Black – African or African-American", "White or Caucasian",
              "Pacific Islander", "Hispanic or Latino", "Other", "Unknown"]

  validates :nationality, inclusion: {in: Client::NATIONALITY, allow_blank: true}
  validates :ethnicity, inclusion: {in: Client::ETHNICITY, allow_blank: true}

  def full_name
    self.first_name + self.last_name
  end

end
