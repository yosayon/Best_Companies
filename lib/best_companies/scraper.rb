class BestCompanies::Scraper
  def self.scrape_companies(url)
    companies = Array.new
    doc = Nokogiri::HTML(open(url))
    doc.css(".thumb-listing .row .col-lg-3 .listing-thumb").each do |company|
      name = company.css(".thumb-text h2").text.split(". ")[1]
      rank = company.css(".thumb-text h2").text.split(". ")[0]
      industry = company.css(".thumb-text h5")[0].text
      location = company.css(".thumb-text h5")[1].text
      review_url = company.css(".thumb-img a").map{|link|link.attribute("href").value}
      companies << {
        :rank => rank,
        :name => name,
        :industry => industry,
        :location => location,
        :review_url => review_url == [] ? "No Review Available" : review_url.join("")
        }
      end
    companies
  end


  def self.scrape_ratings(url)
   ratings = Hash.new
   doc = Nokogiri::HTML(open(url))
   challenges = doc.css(".employee_rating_chart .full_progress span")[0].text
   atmosphere = doc.css(".employee_rating_chart .full_progress span")[1].text
   rewards = doc.css(".employee_rating_chart .full_progress span")[2].text
   pride = doc.css(".employee_rating_chart .full_progress span")[3].text
   communication = doc.css(".employee_rating_chart .full_progress span")[4].text
   bosses = doc.css(".employee_rating_chart .full_progress span")[5].text
   ratings[:challenges] = challenges
   ratings[:atmosphere] = atmosphere
   ratings[:rewards] = rewards
   ratings[:pride] = pride
   ratings[:communication] = communication
   ratings[:bosses] = bosses
   ratings
  end
  
  def self.scrape_awards(url)
    awards = Array.new
    doc = Nokogiri::HTML(open(url))
    awards = doc.css(".awards span.award_list")
    final_awards = awards.children.css("p").map do |award|
    award.text.gsub("\n","").gsub("\t","").gsub(" ","")
    end
    final_awards = final_awards.slice(0,6)
    final_awards
  end

end
