require 'rails_helper'

RSpec.describe "options/index", :type => :view do
  before(:each) do
    assign(:options, [
      Option.create!(
        :name => "Name",
        :image => "Image",
        :score => 1,
        :round_id => 2,
        :url => "Url"
      ),
      Option.create!(
        :name => "Name",
        :image => "Image",
        :score => 1,
        :round_id => 2,
        :url => "Url"
      )
    ])
  end

  it "renders a list of options" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
