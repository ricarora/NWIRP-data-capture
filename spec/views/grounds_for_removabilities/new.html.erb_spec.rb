require 'rails_helper'

RSpec.describe "grounds_for_removabilities/new", :type => :view do
  before(:each) do
    assign(:grounds_for_removability, GroundsForRemovability.new(
      :name => "MyString"
    ))
  end

  it "renders new grounds_for_removability form" do
    render

    assert_select "form[action=?][method=?]", grounds_for_removabilities_path, "post" do

      assert_select "input#grounds_for_removability_name[name=?]", "grounds_for_removability[name]"
    end
  end
end
