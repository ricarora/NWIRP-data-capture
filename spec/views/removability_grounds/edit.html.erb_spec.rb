require 'rails_helper'

RSpec.describe "removability_grounds/edit", :type => :view do
  before(:each) do
    @removability_ground = assign(:removability_ground, RemovabilityGround.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit removability_ground form" do
    render

    assert_select "form[action=?][method=?]", removability_ground_path(@removability_ground), "post" do

      assert_select "input#removability_ground_name[name=?]", "removability_ground[name]"
    end
  end
end
