class Option < ActiveRecord::Base
  attr_accessible :image, :name, :round_id, :score, :url
  
  belongs_to :round
  has_many :votes
  
  def self.create_options(location, term, round_id)
    @options = Yelp.client.search(location, {term: term})
    @options.businesses.each do |option|
      o = Option.create(name: option.name, url: option.url, round_id: round_id)
      if option.has_key?("image_url")
        o.update_attributes(:image => option.image_url)
        o.save
      end
    end
  end
  
end