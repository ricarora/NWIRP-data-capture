require 'rails_helper'

RSpec.describe "clients/show", :type => :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :last_name => "Last Name",
      :first_name => "First Name",
      :nationality => "Nationality",
      :ethnicity => "Ethnicity",
      :gender => "Gender",
      :relief_sought => "Relief Sought",
      :represented => false,
      :drru_case => false,
      :a_number => "A Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Nationality/)
    expect(rendered).to match(/Ethnicity/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Relief Sought/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/A Number/)
  end
end
