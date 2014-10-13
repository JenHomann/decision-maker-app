require 'rails_helper'

RSpec.describe "options/show", :type => :view do
  before(:each) do
    @option = assign(:option, Option.create!(
      :name => "Name",
      :image => "Image",
      :score => 1,
      :round_id => 2,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Url/)
  end
end
