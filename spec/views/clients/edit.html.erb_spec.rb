# require 'rails_helper'
#
# RSpec.describe "clients/edit", :type => :view do
#   before(:each) do
#     @client = assign(:client, Client.create!(
#       :last_name => "MyString",
#       :first_name => "MyString",
#       :nationality => "MyString",
#       :ethnicity => "MyString",
#       :gender => "MyString",
#       :relief_sought => "MyString",
#       :represented => false,
#       :drru_case => false,
#       :a_number => "MyString"
#     ))
#   end
#
#   it "renders the edit client form" do
#     render
#
#     assert_select "form[action=?][method=?]", client_path(@client), "post" do
#
#       assert_select "input#client_last_name[name=?]", "client[last_name]"
# 
#       assert_select "input#client_first_name[name=?]", "client[first_name]"
#
#       assert_select "input#client_nationality[name=?]", "client[nationality]"
#
#       assert_select "input#client_ethnicity[name=?]", "client[ethnicity]"
#
#       assert_select "input#client_gender[name=?]", "client[gender]"
#
#       assert_select "input#client_relief_sought[name=?]", "client[relief_sought]"
#
#       assert_select "input#client_represented[name=?]", "client[represented]"
#
#       assert_select "input#client_drru_case[name=?]", "client[drru_case]"
#
#       assert_select "input#client_a_number[name=?]", "client[a_number]"
#     end
#   end
# end
