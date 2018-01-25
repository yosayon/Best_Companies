class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  puts "Hello! You are in the CLI class right now."
  self.create_list
  puts "You created a list!"
  BestCompanies::Company.see_list
  self.add_ratings
  puts "you successfully added ratings!"
  BestCompanies::Company.see_entire_list
  

 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
 def self.add_ratings
  BestCompanies::Company.all.each do |company|
   if company.review_url != "No Review Available"
    ratings_hash = BestCompanies::Scraper.scrape_ratings(company.review_url)
    company.add_ratings(ratings_hash)
   end
  end
 end
 
 def self.add_awards
  BestCompanies::Company.all.each do |company|
   if company.review_url != "No Review Available"
    awards = BestCompanies::Scraper.scrape_awards(company.review_url)
    company.add_awards(awards)
   end
  end
 end
 
end
