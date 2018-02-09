class BestCompanies::Scraper
 
 def self.scrape_companies(url)
  review_urls = Array.new
  doc = Nokogiri::HTML(open(url))
   ranks = doc.css(".container #list-detail-left-column div.row.company .col-md-5 .rank").text.split(" ")
   names = doc.css(".container #list-detail-left-column div.row.company .col-md-5 a.title").text.split("\n").map{|n|n.gsub(/\s{2}/,"").gsub(/(\,*)(\s*incorporated)*(\s*corporation)*(\s*LLP)*(\s*inc\.*)*(\s*llc\.*)*(\(\w+\))*/i,"")}.slice(1,100)
   industries = doc.css(".container #list-detail-left-column div.row.company .col-md-5 .industry").text.split("\n").map{|i|i.gsub(/\s{2}/,"")}.slice(1,100)
   locations = doc.css(".container #list-detail-left-column div.row.company .col-md-5 .location").text.split("\n").map{|l|l.gsub(/\s{2}/,"")}.slice(1,100)
   review_urls = doc.css(".container .col-xs-12 .col-md-5 a.review-link[href]").map{|l|l["href"]}
   self.create_company_hash(ranks,names,industries,locations,review_urls)
 end
 
 def self.create_company_hash(ranks,names,industries,locations,review_urls)
  companies = Array.new
  count = 0
  while count < 100
   companies << 
   {:rank => ranks[count],
    :name => names[count],
    :industry => industries[count],
    :location => locations[count],
    :review_url => review_urls[count]
   }
   count += 1
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
  award.text.gsub(/(\n)*(\t)*(\s{2,4})/,"")
  end
  final_awards = final_awards.slice(0,6)
  final_awards
  end

end
