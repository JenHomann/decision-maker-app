require 'rails_helper'

RSpec.describe "votes/new", :type => :view do
  before(:each) do
    assign(:vote, Vote.new(
      :points => 1,
      :contact_id => 1,
      :option_id => 1
    ))
  end

  it "renders new vote form" do
    render

    assert_select "form[action=?][method=?]", votes_path, "post" do

      assert_select "input#vote_points[name=?]", "vote[points]"

      assert_select "input#vote_contact_id[name=?]", "vote[contact_id]"

      assert_select "input#vote_option_id[name=?]", "vote[option_id]"
    end
  end
end
