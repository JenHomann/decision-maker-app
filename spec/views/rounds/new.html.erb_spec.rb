require 'rails_helper'

RSpec.describe "rounds/new", :type => :view do
  before(:each) do
    assign(:round, Round.new(
      :name => "MyString",
      :location => "MyString",
      :price_range => "MyString",
      :restaurant_type => "MyString",
      :decision => "MyString",
      :encrypted_url => "MyString"
    ))
  end

  it "renders new round form" do
    render

    assert_select "form[action=?][method=?]", rounds_path, "post" do

      assert_select "input#round_name[name=?]", "round[name]"

      assert_select "input#round_location[name=?]", "round[location]"

      assert_select "input#round_price_range[name=?]", "round[price_range]"

      assert_select "input#round_restaurant_type[name=?]", "round[restaurant_type]"

      assert_select "input#round_decision[name=?]", "round[decision]"

      assert_select "input#round_encrypted_url[name=?]", "round[encrypted_url]"
    end
  end
end
