require 'rails_helper'

RSpec.describe "grounds_for_removabilities/index", :type => :view do
  before(:each) do
    assign(:grounds_for_removabilities, [
      GroundsForRemovability.create!(
        :name => "Name"
      ),
      GroundsForRemovability.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of grounds_for_removabilities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
