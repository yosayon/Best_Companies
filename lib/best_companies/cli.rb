class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  create_list
  add_ratings
  #add_awards
  binding.pry
  ask_user
 end
 
 def self.ask_user
  input = ""
  puts "\nTo see the top 5 Best Companies please type 1-5"
  puts "To see the top 10 Best Companies please type 1-10"
  puts "To see the top 20 Best Companies please type 1-20"
  puts "To see the top 50 Best Companies please type 1-50"
  puts "To see the entire list of Best Companies please type 'see list'"
  puts "To enter in a custom range, type 'custom'"
  puts "To view best companies by state, type 'state'"
  puts "To exit type 'exit"
   
  input = gets.strip.to_s
  
  case input
  when "1-5"
   self.see_list(0,4)
  when "1-10"
   self.see_list(0,9)
  when "1-20"
   self.see_list(0,19)
  when "1-50"
   self.see_list(0,49)
  when "see list"
   self.see_list(0,99)
  when "custom"
   self.custom_list
  when "state"
   BestCompanies::State.list_all_states
  when "exit"
   exit
  else
   puts "That's not a valid input:"
   self.ask_user
  end
  
  while input != "exit"
    self.ask_user
  end
  
 end

 def self.see_list(num1, num2)
  BestCompanies::Company.all.slice(num1..num2).each do |company|
   if company.review_url == "No Review Available"
    puts "\nRank: #{company.rank}"
    puts "Name: #{company.name}"
    puts "Industry: #{company.industry}"
    puts "Location: #{company.location}"
    puts "Review_URL: #{company.review_url}"
    puts "------------------------------------------------"
   else
    puts "\nRank: #{company.rank}"
    puts "Name: #{company.name}"
    puts "Industry: #{company.industry}"
    puts "Location: #{company.location}"
    puts "Review_URL: #{company.review_url}"
    puts "Challenges: #{company.challenges}"
    puts "Atmosphere: #{company.atmosphere}"
    puts "Rewards: #{company.rewards}"
    puts "Pride: #{company.pride}"
    puts "Communication: #{company.communication}"
    puts "Bosses: #{company.bosses}"
    puts "------------------------------------------------"
   end
  end
 end

 def self.custom_list
  puts "Please enter your range between 1-100, separated by a dash. For example: 15-20"
  input = gets.strip.split("-")
  num1 = (input[0].to_i)-1
  num2 = (input[1].to_i)-1
  self.see_list(num1,num2)
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
 def self.add_ratings
  dots = "."
  puts "adding ratings..."
  BestCompanies::Company.all.each do |company|
   print dots
   if company.review_url != "No Review Available"
    ratings_hash = BestCompanies::Scraper.scrape_ratings(company.review_url)
    company.add_ratings(ratings_hash)
   end
  end
 end
 
 #def self.add_awards
 # dots = "."
 # puts "\nadding awards..."
 # BestCompanies::Company.all.each do |company|
 #  print dots
 #  if company.review_url != "No Review Available"
 #   awards = BestCompanies::Scraper.scrape_awards(company.review_url)
 #   company.add_awards(awards)
 #  end
 # end
 #end
 
end