class ConvictionBuildForm
  attr_reader :attributes, :conviction, :errors

  def initialize(attributes, client_id, conviction = nil)
    @attributes = attributes
    @conviction = conviction
    @conviction_ground = nil
    @client_id = client_id
    @errors = {}
  end

  def create
    @conviction = Conviction.new(crime_name: @attributes[:crime_name],
                                rcw: @attributes[:rcw],
                                subsection: @attributes[:subsection],
                                sentence: @attributes[:sentence],
                                ij_name: @attributes[:ij_name],
                                nta_charges: @attributes[:nta_charges],
                                ij_decision_date: @attributes[:ij_decision_date],
                                ij_finding: @attributes[:ij_finding],
                                client_id: @client_id,
                                notes: @attributes[:notes])

  end

  def save
    create
    if @conviction.valid?
      if @attributes[:removability_grounds].has_value?("")
        create_conviction_ground
      else
        @conviction.save
        create_conviction_ground
      end
    else
      @errors[:conviction] = @conviction.errors
      return false
    end
  end

  def create_conviction_ground
    @attributes[:removability_grounds].each do |name, value|
      @conviction_ground = ConvictionGround.new(gor_name: name, status: value)
      @conviction_ground.conviction = @conviction
      @conviction_ground.save
      if @conviction_ground.invalid?
        if @errors[:conviction_ground]
          @errors[:conviction_ground] += [@conviction_ground.errors]
        else
          @errors[:conviction_ground] = [@conviction_ground.errors]
        end
        return false
      end
    end
    return true
  end
end
