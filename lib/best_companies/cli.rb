class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  puts "\nWelcome!".bold
  create_list
  ask_user
 end
 
 def self.ask_user
  input = ""
  puts "\nTo see the top 5 Best Companies please type 1-10".colorize(:light_blue)
  puts "To see the top 20 Best Companies please type 1-20".colorize(:light_blue)
  puts "To see the top 50 Best Companies please type 1-50".colorize(:light_blue)
  puts "To see the entire list of Best Companies please type 'see list'".colorize(:light_blue)
  puts "To enter in a custom range, type 'custom'".colorize(:light_blue)
  puts "To view best companies by state, type 'state'".colorize(:light_blue)
  puts "To exit type 'exit".colorize(:light_blue)
   
  input = gets.strip.to_s
  
  case input
  when "1-10"
   BestCompanies::Company.list_all(0,9)
   self.see_ratings_and_awards
  when "1-20"
   BestCompanies::Company.list_all(0,19)
   self.see_ratings_and_awards
  when "1-50"
   BestCompanies::Company.list_all(0,49)
   self.see_ratings_and_awards
  when "see list"
   BestCompanies::Company.list_all(0,99)
   self.see_ratings_and_awards
  when "custom"
   self.custom_list
   self.see_ratings_and_awards
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
 
 def self.see_ratings_and_awards
  puts "To view the ratings and awards for a company, enter the company rank".colorize(:light_blue)
  puts "Type menu to go back to the main menu".colorize(:light_blue)
  puts "Type archive to see your saved companies".colorize(:light_blue)
  puts "Type exit to exit".colorize(:light_blue)
  puts "------------------------------------------------"
  
  input = gets.strip
  
  case input
  when "menu"
   self.ask_user
  when "archive"
   BestCompanies::Company.archive
  when "exit"
   exit
  else
   self.validate_input(input)
  end
  self.see_ratings_and_awards
 end
 
 def self.validate_input(input)
  if !(input.to_i).between?(1,100)
   puts "Your input was invalid. Please try again"
   puts "------------------------------------------------"
   self.see_ratings_and_awards
  else
   validated_input = BestCompanies::Company.all.detect{|c|c.rank == input}
   url_status = Faraday.get(validated_input.review_url).status
    if validated_input != nil && url_status == 200 
     validated_input.add_ratings(BestCompanies::Scraper.scrape_ratings(validated_input.review_url))
     validated_input.add_awards(BestCompanies::Scraper.scrape_awards(validated_input.review_url))
     self.see_company(validated_input)
     BestCompanies::Company.all[(input.to_i)-1].save?
    else url_status == 404
     puts "This company does not have a review available, please select another company."
     puts "------------------------------------------------"
    end
  end
 end
 
 def self.see_company(company)
  puts "\nRank:".colorize(:red) + " #{company.rank}"
  puts "Name:".colorize(:red) + " #{company.name}"
  puts "Industry:".colorize(:red) + " #{company.industry}"
  puts "Location:".colorize(:red) + " #{company.location}"
  puts "Review_URL:".colorize(:red) + " #{company.review_url}"
  puts "Ratings: \n"
  puts " Challenges:".colorize(:red) + " #{company.challenges}"
  puts " Atmosphere:".colorize(:red) + " #{company.atmosphere}"
  puts " Rewards:".colorize(:red) + " #{company.rewards}"
  puts " Pride:".colorize(:red) + " #{company.pride}"
  puts " Communication:".colorize(:red) + " #{company.communication}"
  puts " Bosses:".colorize(:red) + " #{company.bosses}"
  puts "Awards: \n"
  company.awards.each{|award|puts "#{award}".colorize(:green)}
  puts "------------------------------------------------"
 end

 def self.custom_list
  puts "Please enter your range between 1-100, separated by a dash. For example: 15-20"
  input = gets.strip.split("-")
  num1 = (input[0].to_i)-1
  num2 = (input[1].to_i)-1
  BestCompanies::Company.list_all(num1,num2)
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
end