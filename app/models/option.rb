class Option < ActiveRecord::Base
  attr_accessible :image, :name, :round_id, :score, :url
  
  belongs_to :round
  has_many :votes
  
  def self.create_options(location, term, round_id)
    @options = Yelp.client.search(location, {term: term})
    @options.businesses.each do |option|
      Option.create(name: option.name, image: option.image_url, url: option.url, round_id: round_id)
    end
  end
  
end