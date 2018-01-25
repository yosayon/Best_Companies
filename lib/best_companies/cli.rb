class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  puts "Hello! You are in the CLI class right now."
  create_list
  add_ratings
  add_awards
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
 def self.add_ratings
  BestCompanies::Company.all.each do |company|
   ratings = BestCompanies::Scraper.scrape.ratings(company.review_url)
   company.add_ratings(ratings)
   end
 end
 
 def self.add_awards
  BestCompanies::Company.all.each do |company|
   awards = BestCompanies::Scraper.scrape_awards(company.review_url)
   company.add_awards(awards)
   end
 end
 
end