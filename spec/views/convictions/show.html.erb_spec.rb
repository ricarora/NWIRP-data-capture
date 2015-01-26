require 'rails_helper'

RSpec.describe "convictions/show", :type => :view do
  before(:each) do
    @conviction = assign(:conviction, Conviction.create!(
      :crime_name => "Crime Name",
      :rcw => "Rcw",
      :subsection => "Subsection",
      :sentence => 1,
      :ij_name => "Ij Name",
      :nta_charges => "Nta Charges",
      :ij_finding => "Ij Finding",
      :client_id => 2,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Crime Name/)
    expect(rendered).to match(/Rcw/)
    expect(rendered).to match(/Subsection/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Ij Name/)
    expect(rendered).to match(/Nta Charges/)
    expect(rendered).to match(/Ij Finding/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
