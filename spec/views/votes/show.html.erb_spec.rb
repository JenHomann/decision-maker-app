require 'rails_helper'

RSpec.describe "votes/show", :type => :view do
  before(:each) do
    @vote = assign(:vote, Vote.create!(
      :points => 1,
      :contact_id => 2,
      :option_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
