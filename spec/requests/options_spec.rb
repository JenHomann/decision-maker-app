require 'rails_helper'

RSpec.describe "Options", :type => :request do
  describe "GET /options" do
    it "works! (now write some real specs)" do
      get options_path
      expect(response.status).to be(200)
    end
  end
end
