require 'rails_helper'

RSpec.describe "votes/edit", :type => :view do
  before(:each) do
    @vote = assign(:vote, Vote.create!(
      :points => 1,
      :contact_id => 1,
      :option_id => 1
    ))
  end

  it "renders the edit vote form" do
    render

    assert_select "form[action=?][method=?]", vote_path(@vote), "post" do

      assert_select "input#vote_points[name=?]", "vote[points]"

      assert_select "input#vote_contact_id[name=?]", "vote[contact_id]"

      assert_select "input#vote_option_id[name=?]", "vote[option_id]"
    end
  end
end
