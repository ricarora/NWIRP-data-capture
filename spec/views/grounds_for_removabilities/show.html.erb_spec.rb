require 'rails_helper'

RSpec.describe "grounds_for_removabilities/show", :type => :view do
  before(:each) do
    @grounds_for_removability = assign(:grounds_for_removability, GroundsForRemovability.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
