require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "https://www.realtor.com/apartments/33334"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  listings = Array.new
  rental_listing = parsed_page.css('li.component_property-card.js-component_property-card')
  page = 1
  per_page = rental_listing.count #48
  total = parsed_page.css('span#search-result-count.page-title').text.tr("\n","").to_i
  last_page = (total / per_page).round #2
  while page <= last_page
     pagination_url = "https://www.realtor.com/apartments/33334/pg-#{page}"
     pagination_unparsed_page = HTTParty.get(pagination_url)
     pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
    rental_listing.each do |rental_listing|
      listing = {
        address: rental_listing.css('span.listing-street-address').text,
        town: rental_listing.css('span.listing-city').text,
        beds: rental_listing.css('span.data-value.meta-beds-display').text,
        price: rental_listing.css('span.data-price').text
      }
      listings << listing

    end
  byebug
end

end
scraper
