require 'rails_helper'

RSpec.describe "votes/index", :type => :view do
  before(:each) do
    assign(:votes, [
      Vote.create!(
        :points => 1,
        :contact_id => 2,
        :option_id => 3
      ),
      Vote.create!(
        :points => 1,
        :contact_id => 2,
        :option_id => 3
      )
    ])
  end

  it "renders a list of votes" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
