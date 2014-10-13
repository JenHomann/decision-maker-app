require 'rails_helper'

RSpec.describe "rounds/index", :type => :view do
  before(:each) do
    assign(:rounds, [
      Round.create!(
        :name => "Name",
        :location => "Location",
        :price_range => "Price Range",
        :restaurant_type => "Restaurant Type",
        :decision => "Decision",
        :encrypted_url => "Encrypted Url"
      ),
      Round.create!(
        :name => "Name",
        :location => "Location",
        :price_range => "Price Range",
        :restaurant_type => "Restaurant Type",
        :decision => "Decision",
        :encrypted_url => "Encrypted Url"
      )
    ])
  end

  it "renders a list of rounds" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Price Range".to_s, :count => 2
    assert_select "tr>td", :text => "Restaurant Type".to_s, :count => 2
    assert_select "tr>td", :text => "Decision".to_s, :count => 2
    assert_select "tr>td", :text => "Encrypted Url".to_s, :count => 2
  end
end
