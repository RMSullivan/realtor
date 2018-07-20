require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "https://www.realtor.com/apartments/33334"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  rental_listings = parsed_page.css('li#1.component_property-card.js-component_property-card')
  rental_listings.each do |rental_listing|
    listing = {
      address: rental_listings.css('span.listing-street-address').text,
      town: rental_listings.css('span.listing-city').text,
      beds: rental_listings.css('span.data-value.meta-beds-display').text,
      price: rental_listings.css('span.data-price').text
    }
    byebug
  end

end


scraper
