class Client < ActiveRecord::Base
  has_many :assessments, autosave: true
  has_many :convictions
  has_many :relief_soughts, through: :client_reliefs
  has_many :client_reliefs, autosave: true
  validates_uniqueness_of :a_number
  validates :first_name, :last_name, :gender, :a_number, :nationality, presence: true
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
  validates :represented, :drru_case, :inclusion => {:in => [true, false]}

  GENDER = ["Male", "Female", "Transgender"]

  NATIONALITY = [ "Unknown", "Afghan", "Albanian", "Algerian", "American", "Andorran",
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
                "Vietnamese", "Welsh", "Yemenite", "Zambian", "Zimbabwean"]

  validates :nationality, :inclusion => {:in => Client::NATIONALITY}

  def full_name
    self.first_name + self.last_name
  end

end
