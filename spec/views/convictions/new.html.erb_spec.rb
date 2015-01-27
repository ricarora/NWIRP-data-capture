# require 'rails_helper'
#
# RSpec.describe "convictions/new", :type => :view do
#   before(:each) do
#     assign(:conviction, Conviction.new(
#       :crime_name => "MyString",
#       :rcw => "MyString",
#       :subsection => "MyString",
#       :sentence => 1,
#       :ij_name => "MyString",
#       :nta_charges => "MyString",
#       :ij_finding => "MyString",
#       :client_id => 1,
#       :notes => "MyText"
#     ))
#   end
#
#   it "renders new conviction form" do
#     render
#
#     assert_select "form[action=?][method=?]", convictions_path, "post" do
#
#       assert_select "input#conviction_crime_name[name=?]", "conviction[crime_name]"
#
#       assert_select "input#conviction_rcw[name=?]", "conviction[rcw]"
#
#       assert_select "input#conviction_subsection[name=?]", "conviction[subsection]"
#
#       assert_select "input#conviction_sentence[name=?]", "conviction[sentence]"
#
#       assert_select "input#conviction_ij_name[name=?]", "conviction[ij_name]"
#
#       assert_select "input#conviction_nta_charges[name=?]", "conviction[nta_charges]"
#
#       assert_select "input#conviction_ij_finding[name=?]", "conviction[ij_finding]"
#
#       assert_select "input#conviction_client_id[name=?]", "conviction[client_id]"
#
#       assert_select "textarea#conviction_notes[name=?]", "conviction[notes]"
#     end
#   end
# end
