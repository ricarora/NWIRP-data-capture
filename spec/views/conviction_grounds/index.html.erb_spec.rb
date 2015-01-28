# require 'rails_helper'
#
# RSpec.describe "conviction_grounds/index", :type => :view do
#   before(:each) do
#     assign(:conviction_grounds, [
#       ConvictionGround.create!(
#         :gor_name => "Gor Name",
#         :conviction_id => 1,
#         :status => "Status"
#       ),
#       ConvictionGround.create!(
#         :gor_name => "Gor Name",
#         :conviction_id => 1,
#         :status => "Status"
#       )
#     ])
#   end
#
#   it "renders a list of conviction_grounds" do
#     render
#     assert_select "tr>td", :text => "Gor Name".to_s, :count => 2
#     assert_select "tr>td", :text => 1.to_s, :count => 2
#     assert_select "tr>td", :text => "Status".to_s, :count => 2
#   end
# end
