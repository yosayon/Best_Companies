require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_companies
    companies = Array.new
    doc = Nokogiri::HTML(open("https://www.greatplacetowork.com/best-workplaces/100-best/2017"))
    doc.css(".thumb-listing .row .col-lg-3 .listing-thumb").each do |company|
      name = company.css(".thumb-text h2").text
      industry = company.css(".thumb-text h5")[0].text
      location = company.css(".thumb-text h5")[1].text
      review_link = company.css(".thumb-img a").map{|link|link.attribute("href").value}
      companies << {
        :name => name,
        :industry => industry,
        :location => location,
        :review_link => review_link == [] ? "No Review Available" : review.join("")
        }
      end
    companies
  end


  def self.review_links
   ratings = Hash.new
   link = "http://reviews.greatplacetowork.com/wegmans-food-markets-inc"
   doc = Nokogiri::HTML(open(link))
   great_challenges = doc.css(".employee_rating_chart .full_progress span")[0].text
   great_atmosphere = doc.css(".employee_rating_chart .full_progress span")[1].text
   ratings[:great_challenges] = great_challenges
   ratings[:great_atmosphere] = great_atmosphere
   #add the rest of the ratings

  binding.pry
  end


end

Scraper.review_links