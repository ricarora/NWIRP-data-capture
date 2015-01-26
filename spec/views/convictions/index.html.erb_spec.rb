require 'rails_helper'

RSpec.describe "convictions/index", :type => :view do
  before(:each) do
    assign(:convictions, [
      Conviction.create!(
        :crime_name => "Crime Name",
        :rcw => "Rcw",
        :subsection => "Subsection",
        :sentence => 1,
        :ij_name => "Ij Name",
        :nta_charges => "Nta Charges",
        :ij_finding => "Ij Finding",
        :client_id => 2,
        :notes => "MyText"
      ),
      Conviction.create!(
        :crime_name => "Crime Name",
        :rcw => "Rcw",
        :subsection => "Subsection",
        :sentence => 1,
        :ij_name => "Ij Name",
        :nta_charges => "Nta Charges",
        :ij_finding => "Ij Finding",
        :client_id => 2,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of convictions" do
    render
    assert_select "tr>td", :text => "Crime Name".to_s, :count => 2
    assert_select "tr>td", :text => "Rcw".to_s, :count => 2
    assert_select "tr>td", :text => "Subsection".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Ij Name".to_s, :count => 2
    assert_select "tr>td", :text => "Nta Charges".to_s, :count => 2
    assert_select "tr>td", :text => "Ij Finding".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
