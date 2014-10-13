require 'rails_helper'

RSpec.describe "options/edit", :type => :view do
  before(:each) do
    @option = assign(:option, Option.create!(
      :name => "MyString",
      :image => "MyString",
      :score => 1,
      :round_id => 1,
      :url => "MyString"
    ))
  end

  it "renders the edit option form" do
    render

    assert_select "form[action=?][method=?]", option_path(@option), "post" do

      assert_select "input#option_name[name=?]", "option[name]"

      assert_select "input#option_image[name=?]", "option[image]"

      assert_select "input#option_score[name=?]", "option[score]"

      assert_select "input#option_round_id[name=?]", "option[round_id]"

      assert_select "input#option_url[name=?]", "option[url]"
    end
  end
end
