require 'rails_helper'

RSpec.describe "removability_grounds/new", :type => :view do
  before(:each) do
    assign(:removability_ground, RemovabilityGround.new(
      :name => "MyString"
    ))
  end

  it "renders new removability_ground form" do
    render

    assert_select "form[action=?][method=?]", removability_grounds_path, "post" do

      assert_select "input#removability_ground_name[name=?]", "removability_ground[name]"
    end
  end
end
