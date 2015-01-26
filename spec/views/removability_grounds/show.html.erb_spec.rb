require 'rails_helper'

RSpec.describe "removability_grounds/show", :type => :view do
  before(:each) do
    @removability_ground = assign(:removability_ground, RemovabilityGround.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
