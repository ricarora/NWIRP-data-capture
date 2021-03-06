# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class Client < ActiveRecord::Base
  has_many :assessments, autosave: true, :dependent => :destroy
  has_many :convictions
  has_many :relief_soughts, through: :client_reliefs
  has_many :client_reliefs, autosave: true, :dependent => :destroy
  validates :last_name, :a_number, :assessments, presence: true
  validates :a_number, format: { with: /\d{3}-\d{3}-\d{3}/,
    message: "Only allows numbers in this format: XXX-XXX-XXX." }
  validates :gender, inclusion: { in: %w(Male Female Other Unknown),
    message: "Only accepts Male, Female, Other, or Unknown.", allow_blank: true}
  validates :drru_case, inclusion: {in: [true, false], allow_blank: true}
  validates :represented, inclusion: { in: %w(Yes No Unknown),
    message: "Only accepts Yes, No, or Unknown.", allow_blank: true}
  validate :validate_a_number_uniqueness

  accepts_nested_attributes_for :client_reliefs, :assessments, allow_destroy: true,
      :reject_if => proc {|attributes|
        attributes.all? {|k,v| v.blank?}
      }

  def self.to_csv(list, options = {})
    column_names = ["last_name",
                    "first_name",
                    "middle_name",
                    "nationality",
                    "ethnicity",
                    "gender",
                    "represented",
                    "drru_case"]
    CSV.generate(options) do |csv|
      csv << column_names
      list.each do |client|
        csv << client.attributes.values_at(*column_names)
      end
    end
  end

  def validate_a_number_uniqueness
    Client.all.reject {|client| client.id == self.id}.each do |client|
      if client.a_number == self.a_number
        errors.add(:a_number, "A# already exists")
      end
    end
  end

  attr_encrypted :a_number, :key => 'a secret key'

  before_save :name_cap

  def name_cap
    self.last_name = self.last_name.capitalize
    if self.first_name != nil
      self.first_name = self.first_name.capitalize
    end
  end

  GENDER = ["Male", "Female", "Other", "Unknown"]

  REPRESENTED = ["Yes", "No", "Unknown"]

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

  ETHNICITY = ["Asian – not Pacific Islander", "Black – African or African-American",
              "Hispanic or Latino", "Native American or Alaska Native",
              "Pacific Islander", "White or Caucasian", "Other", "Unknown"]

  validates :nationality, inclusion: {in: Client::NATIONALITY, allow_blank: true}
  validate :validate_ethnicity

  def validate_ethnicity
    if ethnicity != []
      ethnicity.each do |selection|
        if !ethnicity.is_a?(Array) || !Client::ETHNICITY.include?(selection)
          errors.add(:ethnicity, :invalid)
        end
      end
    end
  end

  def self.find_client_by_a_number(a_number)
    if a_number
      self.all.to_a.find { |client| client.a_number == a_number }
    end
  end

  def self.find_client_by_name(last_name, first_name)
    if last_name && first_name
      @clients = self.all.where("last_name ILIKE ? AND first_name ILIKE ?", "%#{last_name}%", "%#{first_name}%")
      @clients.to_a
    elsif last_name
      @clients = self.all.where("last_name ILIKE ?", "%#{last_name}%")
    else first_name
      @clients = self.all.where("first_name ILIKE ?", "%#{first_name}%")
      @clients.to_a
    end
  end

  def DRRU_CASE
    self.drru_case ? "Yes" : "No"
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||', parent.table[:first_name], ' '),
      parent.table[:last_name])
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(first_name middle_name last_name nationality gender represented drru_case) + _ransackers.keys
  end
end
