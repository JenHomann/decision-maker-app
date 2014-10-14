class PagesController < ApplicationController

  # Initial user inputs contact information
  def home
    @contact = Contact.new
  end

end