class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  create_list
  
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.new.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
end