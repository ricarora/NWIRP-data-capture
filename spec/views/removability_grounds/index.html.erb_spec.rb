require 'rails_helper'

RSpec.describe "removability_grounds/index", :type => :view do
  before(:each) do
    assign(:removability_grounds, [
      RemovabilityGround.create!(
        :name => "Name"
      ),
      RemovabilityGround.create!(
        :name => "DV"
      )
    ])
  end

  it "renders a list of removability_grounds" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
  end
end
