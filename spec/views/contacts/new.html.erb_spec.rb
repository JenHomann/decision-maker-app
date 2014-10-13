require 'rails_helper'

RSpec.describe "contacts/new", :type => :view do
  before(:each) do
    assign(:contact, Contact.new(
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :voted? => false,
      :encrypted_id => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_phone[name=?]", "contact[phone]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_voted?[name=?]", "contact[voted?]"

      assert_select "input#contact_encrypted_id[name=?]", "contact[encrypted_id]"
    end
  end
end
