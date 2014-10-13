require 'rails_helper'

RSpec.describe "contacts/show", :type => :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :name => "Name",
      :phone => "Phone",
      :email => "Email",
      :voted? => false,
      :encrypted_id => "Encrypted"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Encrypted/)
  end
end
