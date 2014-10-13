require 'rails_helper'

RSpec.describe "contacts/index", :type => :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :voted? => false,
        :encrypted_id => "Encrypted"
      ),
      Contact.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :voted? => false,
        :encrypted_id => "Encrypted"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Encrypted".to_s, :count => 2
  end
end
