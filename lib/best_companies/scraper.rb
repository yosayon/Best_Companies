class BestCompanies::Scraper
 def self.scrape_companies(url)
  companies = Array.new
  doc = Nokogiri::HTML(open(url))
  doc.css(".container #list-detail-left-column div.row.company .col-md-5").children.each do |company|
   ranks = company.css(".rank.large").text.split(" ")
   names = company.css("a.title").text.split("\n").map do |name|
    name.gsub(/\s{2,6}/,"").gsub(/(\,*)(\s*incorporated)*(\s*corporation)*(\s*LLP)*(\s*inc\.*)*(\s*llc\.*)*(\(\w+\))*/i,"").gsub("(SAP America)","")
   end
   industries = company.css(".industry").text.split("\n").map{|i|i.gsub(/\s{2,6}/,"")}
   #industry = company.css(".thumb-text h5")[0].text
   #location = company.css(".thumb-text h5")[1].text
   #review_url = company.css(".thumb-img a").map{|link|link.attribute("href").value}
   #companies << {
   # :rank => rank,
   # :name => name.gsub(/\d+\.\s/,"").gsub(/(\,*)(\s*incorporated)*(\s*corporation)*(\s*LLP)*(\s*inc\.*)*(\s*llc\.*)*(\(\w+\))*/i,"").gsub("(SAP America)",""),
   # :industry => industry,
   # :location => location,
   # :review_url => review_url == [] ? "No Review Available" : review_url.join("")}
  end
  binding.pry
   #companies
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
