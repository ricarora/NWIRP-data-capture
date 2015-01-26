require 'rails_helper'

RSpec.describe "conviction_grounds/edit", :type => :view do
  before(:each) do
    @conviction_ground = assign(:conviction_ground, ConvictionGround.create!(
      :gor_name => "MyString",
      :conviction_id => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit conviction_ground form" do
    render

    assert_select "form[action=?][method=?]", conviction_ground_path(@conviction_ground), "post" do

      assert_select "input#conviction_ground_gor_name[name=?]", "conviction_ground[gor_name]"

      assert_select "input#conviction_ground_conviction_id[name=?]", "conviction_ground[conviction_id]"

      assert_select "input#conviction_ground_status[name=?]", "conviction_ground[status]"
    end
  end
end
