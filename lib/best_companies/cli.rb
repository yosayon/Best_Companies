class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  create_list
  puts "Welcome!"
  puts "To see the top 5 Best Companies please type 1-5"
  puts "To see the top 10 Best Companies please type 1-10"
  puts "To see the top 20 Best Companies please type 1-20"
  puts "To see the top 50 Best Companies please type 1-50"
  puts "To see the entire list of Best Companies please type 'see list'."
  puts "To enter in a custom range between 1-100, please include a dash. For example, '15-20'."
  input = gets.strip.to_s
  
  case input
  when "1-5"
   self.see_list(5)
  when "1-10"
   self.see_list(10)
  when "1-20"
   self.see_list(20)
  when "1-50"
   self.see_list(50)
  when "see list"
   self.see_list(100)
   else
    puts "That's not a valid input:"
    self.start
  end
 end
 
 def self.see_list(range)
  BestCompanies::Company.all.slice(0, range.to_i).each do |company|
   puts "Name: #{company.name}"
   puts "Industry: #{company.industry}"
   puts "Location: #{company.location}"
   puts "Review_URL: #{company.review_url}"
   puts "------------------------------"
   end
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
 def self.add_ratings
  puts "adding ratings.....this may take a moment"
  BestCompanies::Company.all.each do |company|
   if company.review_url != "No Review Available"
    puts "..."
    ratings_hash = BestCompanies::Scraper.scrape_ratings(company.review_url)
    company.add_ratings(ratings_hash)
   end
  end
 end
 
 def self.add_awards
  puts "adding awards.....this may take a moment"
  BestCompanies::Company.all.each do |company|
   if company.review_url != "No Review Available"
    awards = BestCompanies::Scraper.scrape_awards(company.review_url)
    company.add_awards(awards)
   end
  end
 end
 
end
