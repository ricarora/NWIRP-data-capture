class ConvictionBuildForm
  attr_reader :conviction
  def initialize(attributes, client)
    @attributes = attributes
    @client = client
  end

  def save
    @conviction = Conviction.create()

  end

end
