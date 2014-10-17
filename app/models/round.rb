class Round < ActiveRecord::Base
  attr_accessible :decision, :encrypted_url, :location, :name, :price_range, :restaurant_type
  
  require 'securerandom'
  
  has_many :contacts
  has_many :options
  
  # accepts_nested_attributes_for :contacts, :allow_destroy => true, :reject_if :email_is_blank
  #
  # # Evaluates whether an email has been submitted
  # def email_is_blank
  #   if attrs['email'].blank?
  #     true
  #   else
  #     false
  #   end
  # end
  
  # Sets the encrypted_url
  def set_encrypted_url
    self.encrypted_url = SecureRandom.hex
  end
  
  def set_restaurant_type_options
    return ["Fast Food", "American (Traditional)", "Mexican", "Pizza", "Burgers", "Sandwiches", "Bars" "American (New)", "Chinese", "Italian", "Chicken Wings", "Deli", "Barbeque", "Breakfast & Brunch", "Steakhouse", "Tex-Mex", "Sports Bar", "Cafe", "Diner", "Seafood", "Bakery", "Sushi"]
  end
    
    # Afghan
    # African
    # American (New)
    # American (Traditional)
    # Arabian
    # Argentine
    # Armenian
    # Asian Fusion
    # Australian
    # Austrian
    # Bangladeshi
    # Barbeque
    # Basque
    # Belgian
    # Brasseries
    # Brazilian
    # Breakfast & Brunch
    # British
    # Buffets
    # Burgers
    # Burmese
    # Cafes
    # Cafeteria
    # Cajun/Creole
    # Cambodian
    # Caribbean
    # Catalan
    # Cheesesteaks
    # Chicken Wings
    # Chinese
    # Comfort Food
    # Creperies
    # Cuban
    # Czech
    # Delis
    # Diners
    # Ethiopian
    # Fast Food
    # Filipino
    # Fish & Chips
    # Fondue
    # Food Court
    # Food Stands
    # French
    # Gastropubs
    # German
    # Gluten-Free
    # Greek
    # Halal
    # Hawaiian
    # Himalayan/Nepalese
    # Hot Dogs
    # Hot Pot
    # Hungarian
    # Iberian
    # Indian
    # Indonesian
    # Irish
    # Italian
    # Japanese
    # Korean
    # Kosher
    # Laotian
    # Latin American
    # Live/Raw Food
    # Malaysian
    # Mediterranean
    # Mexican
    # Middle Eastern
    # Modern European
    # Mongolian
    # Moroccan
    # Pakistani
    # Persian/Iranian
    # Peruvian
    # Pizza
    # Polish
    # Portuguese
    # Russian
    # Salad
    # Sandwiches
    # Scandinavian
    # Scottish
    # Seafood
    # Singaporean
    # Slovakian
    # Soul Food
    # Soup
    # Southern
    # Spanish
    # Steakhouses
    # Sushi Bars
    # Taiwanese
    # Tapas Bars
    # Tapas/Small Plates
    # Tex-Mex
    # Thai
    # Turkish
    # Ukrainian
    # Uzbek
    # Vegan
    # Vegetarian
    # Vietnamese
  
end