require 'rails_helper'

RSpec.describe "conviction_grounds/show", :type => :view do
  before(:each) do
    @conviction_ground = assign(:conviction_ground, ConvictionGround.create!(
      :gor_name => "Gor Name",
      :conviction_id => 1,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Gor Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Status/)
  end
end
