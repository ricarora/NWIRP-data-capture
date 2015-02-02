class ConvictionBuildForm
  attr_reader :conviction, :errors

  def initialize(attributes, client_id, conviction = nil)
    @attributes = attributes
    @conviction = conviction
    @client_id = client_id
    @errors = {}
  end

  def save
    @conviction = Conviction.create(crime_name: @attributes[:crime_name],
                                    rcw: @attributes[:rcw],
                                    subsection: @attributes[:subsection],
                                    sentence: @attributes[:sentence],
                                    ij_name: @attributes[:ij_name],
                                    nta_charges: @attributes[:nta_charges],
                                    ij_decision_date: @attributes[:ij_decision_date],
                                    ij_finding: @attributes[:ij_finding],
                                    client_id: @client_id,
                                    notes: @attributes[:notes])
    if @conviction.errors.any?
      @errors[:conviction]=@conviction.errors
    end

    if !@conviction.id.nil?
      @attributes[:removability_grounds].each do |name, value|
        conviction_ground = ConvictionGround.create(gor_name: name, conviction_id: @conviction.id, status: value)
        if conviction_ground.errors.any?
          if @errors[:removability_grounds]
            @errors[:removability_grounds] += [removability_grounds.errors]
          else
            @errors[:removability_grounds] = [removability_grounds.errors]
          end
        end
      end
    end
    @conviction.valid?
  end

end
