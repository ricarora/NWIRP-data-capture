class ConvictionBuildForm
  attr_reader :conviction
  def initialize(attributes, conviction = nil)
    @attributes = attributes
    @conviction = conviction
  end

  def save
    raise
    @conviction = Conviction.create(crime_name: @attributes[:crime_name],
                                    rcw: @attributes[:rcw],
                                    subsection: @attributes[:subsection],
                                    sentence: @attributes[:sentence],
                                    ij_name: @attributes[:ij_name],
                                    nta_charges: @attributes[:nta_charges],
                                    ij_decision_date: Date.parse(@attributes[:ij_decision_date]),
                                    ij_finding: @attributes[:ij_finding],
                                    client_id: @attributes[:client_id],
                                    notes: @attributes[:notes])
    @attributes[:removability_grounds].each do |name, value|
      ConvictionGround.create(gor_name: name, conviction_id: @conviction.id, status: value)
    end
    @conviction.valid?
  end

end
