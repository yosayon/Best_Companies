class BestCompanies::Scraper
 
 def self.scrape_companies(url,year)
  review_urls = Array.new
  doc = Nokogiri::HTML(open(url))
  scraped_companies = Array.new
  
  doc.search("#list-detail-left-column div.row.company .col-md-5").collect do |company|
   rank = company.css(".rank").text.gsub(/\s{2,}/,"")
   year = year
   name = company.css(".title").text.gsub(/\s{2,}/,"")
   industry = company.css(".industry").text.gsub(/\s{2,}/,"")
   location = company.css(".location").text.gsub(/\s{2,}/,"")
   review_url = company.css(".review-link").attr("href").value
   scraped_companies << {:rank => rank, :year => year, :name => name, :industry => industry, :location => location, :review_url => review_url}
  end
  scraped_companies
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
  award.text.gsub(/(\n)*(\t)*(\s{2,4})/,"")
  end
  final_awards = final_awards.slice(0,6)
  final_awards
  end

end