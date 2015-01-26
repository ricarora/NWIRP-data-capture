require 'rails_helper'

RSpec.describe "grounds_for_removabilities/edit", :type => :view do
  before(:each) do
    @grounds_for_removability = assign(:grounds_for_removability, GroundsForRemovability.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit grounds_for_removability form" do
    render

    assert_select "form[action=?][method=?]", grounds_for_removability_path(@grounds_for_removability), "post" do

      assert_select "input#grounds_for_removability_name[name=?]", "grounds_for_removability[name]"
    end
  end
end
