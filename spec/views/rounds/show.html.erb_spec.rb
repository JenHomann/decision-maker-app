require 'rails_helper'

RSpec.describe "rounds/show", :type => :view do
  before(:each) do
    @round = assign(:round, Round.create!(
      :name => "Name",
      :location => "Location",
      :price_range => "Price Range",
      :restaurant_type => "Restaurant Type",
      :decision => "Decision",
      :encrypted_url => "Encrypted Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Price Range/)
    expect(rendered).to match(/Restaurant Type/)
    expect(rendered).to match(/Decision/)
    expect(rendered).to match(/Encrypted Url/)
  end
end
