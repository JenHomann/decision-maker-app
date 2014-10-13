require 'rails_helper'

RSpec.describe "options/new", :type => :view do
  before(:each) do
    assign(:option, Option.new(
      :name => "MyString",
      :image => "MyString",
      :score => 1,
      :round_id => 1,
      :url => "MyString"
    ))
  end

  it "renders new option form" do
    render

    assert_select "form[action=?][method=?]", options_path, "post" do

      assert_select "input#option_name[name=?]", "option[name]"

      assert_select "input#option_image[name=?]", "option[image]"

      assert_select "input#option_score[name=?]", "option[score]"

      assert_select "input#option_round_id[name=?]", "option[round_id]"

      assert_select "input#option_url[name=?]", "option[url]"
    end
  end
end
