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


  def self.scrape_ratings
   ratings = Hash.new
   link = "http://reviews.greatplacetowork.com/wegmans-food-markets-inc"
   doc = Nokogiri::HTML(open(link))
   great_challenges = doc.css(".employee_rating_chart .full_progress span")[0].text
   great_atmosphere = doc.css(".employee_rating_chart .full_progress span")[1].text
   great_rewards = doc.css(".employee_rating_chart .full_progress span")[2].text
   great_pride = doc.css(".employee_rating_chart .full_progress span")[3].text
   great_communication = doc.css(".employee_rating_chart .full_progress span")[4].text
   great_bosses = doc.css(".employee_rating_chart .full_progress span")[5].text
   ratings[:great_challenges] = great_challenges
   ratings[:great_atmosphere] = great_atmosphere
   ratings[:great_rewards] = great_rewards
   ratings[:great_pride] = great_pride
   ratings[:great_communication] = great_communication
   ratings[:great_bosses] = great_bosses
  end
  
  def self.scrape_awards
   # awards = Hash.new
    link = "http://reviews.greatplacetowork.com/wegmans-food-markets-inc"
    doc = Nokogiri::HTML(open(link))
    awards = doc.css(".awards span.award_list")
    
    final_awards = awards.children.css("p").map do |award|
        award.text.gsub("\n","").gsub("\t","").gsub(" ","")
    end
    #figure out how to separate the awards into it's own hash.
    final_awards = final_awards.slice(0,6)
    #figure out if all companies have a minimum of 6 awards
    binding.pry
  end


end

Scraper.scrape_awards