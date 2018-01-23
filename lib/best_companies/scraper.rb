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


  def self.review_links(review)
   doc = Nokogiri::HTML(open(review_link))
   #find a way to scrape the review links and put it into a hash
  
  binding.pry
  end


end

Scraper.review_links