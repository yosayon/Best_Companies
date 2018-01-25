class BestCompanies::Scraper
  def scrape_companies
    companies = Array.new
    doc = Nokogiri::HTML(open("https://www.greatplacetowork.com/best-workplaces/100-best/2017"))
    doc.css(".thumb-listing .row .col-lg-3 .listing-thumb").each do |company|
      name = company.css(".thumb-text h2").text
      industry = company.css(".thumb-text h5")[0].text
      location = company.css(".thumb-text h5")[1].text
      review_url = company.css(".thumb-img a").map{|link|link.attribute("href").value}
      companies << {
        :name => name,
        :industry => industry,
        :location => location,
        :review_url => review_url == [] ? "No Review Available" : review.join("")
        }
      end
    companies
  end


  def scrape_ratings(url)
   ratings = Hash.new
   doc = Nokogiri::HTML(open(url))
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
  
  def scrape_awards(url)
    awards = Hash.new
    doc = Nokogiri::HTML(open(review_link))
    awards = doc.css(".awards span.award_list")
    final_awards = awards.children.css("p").map do |award|
        award.text.gsub("\n","").gsub("\t","").gsub(" ","")
    end
    final_awards = final_awards.slice(0,6)
  end
  
  def create_companies
  end
end

