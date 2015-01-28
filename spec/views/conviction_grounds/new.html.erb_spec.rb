# require 'rails_helper'
#
# RSpec.describe "conviction_grounds/new", :type => :view do
#   before(:each) do
#     assign(:conviction_ground, ConvictionGround.new(
#       :gor_name => "MyString",
#       :conviction_id => 1,
#       :status => "MyString"
#     ))
#   end
#
#   it "renders new conviction_ground form" do
#     render
#
#     assert_select "form[action=?][method=?]", conviction_grounds_path, "post" do
#
#       assert_select "input#conviction_ground_gor_name[name=?]", "conviction_ground[gor_name]"
#
#       assert_select "input#conviction_ground_conviction_id[name=?]", "conviction_ground[conviction_id]"
#
#       assert_select "input#conviction_ground_status[name=?]", "conviction_ground[status]"
#     end
#   end
# end
