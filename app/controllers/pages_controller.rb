class PagesController < ApplicationController

  def home
    @contact = Contact.new
    @round = Round.new
  end

end
