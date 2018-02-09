class BestCompanies::CLI
 BASE_PATH = "https://www.greatplacetowork.com/best-workplaces/100-best/2017"
    
 def self.start
  puts "\nWelcome!".bold
  create_list
  ask_user
 end
 
 def self.create_list
  company_hash = BestCompanies::Scraper.scrape_companies(BASE_PATH)
  BestCompanies::Company.create_from_list(company_hash)
 end
 
 def self.ask_user
  input = ""
  puts "\n------------------------------------------------"
  puts "To see the top 10 Best Companies please type 1-10".colorize(:light_blue)
  puts "To see the top 20 Best Companies please type 1-20".colorize(:light_blue)
  puts "To see the top 50 Best Companies please type 1-50".colorize(:light_blue)
  puts "To see the entire list of Best Companies please type 'see list'".colorize(:light_blue)
  puts "To enter in a custom range, type 'custom'".colorize(:light_blue)
  puts "To view best companies by state, type 'state'".colorize(:light_blue)
  puts "To exit type 'exit".colorize(:light_blue)
  puts "------------------------------------------------"
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
  puts "To enter in a custom range, type 'custom'".colorize(:light_blue)
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
  when "custom"
   self.custom_list
  when "exit"
   exit
  else
   self.validate_input(input)
  end
  self.see_ratings_and_awards
 end
 
 def self.validate_input(input)
  if !(input.to_i).between?(1,100)
   puts "Your input was invalid."
   puts "------------------------------------------------"
   self.ask_user
  else
   validated_input = BestCompanies::Company.all.detect{|c|c.rank == input}
    if validated_input != nil && validated_input.review_url != "No Review Available"
     validated_input.add_ratings(BestCompanies::Scraper.scrape_ratings(validated_input.review_url))
     validated_input.add_awards(BestCompanies::Scraper.scrape_awards(validated_input.review_url))
     self.see_company(validated_input)
     BestCompanies::Company.all[(input.to_i)-1].save?
    else
     BestCompanies::Company.list_all((input.to_i)-1, (input.to_i)-1)
     puts "This company does not have a review available\n".colorize(:light_blue)
     BestCompanies::Company.all[(input.to_i)-1].save?
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
  if company.review_url != "No Review Available"
   puts "Ratings:".colorize(:red)
   puts " Challenges:" + " #{company.challenges}"
   puts " Atmosphere:". + " #{company.atmosphere}"
   puts " Rewards:" + " #{company.rewards}"
   puts " Pride:" + " #{company.pride}"
   puts " Communication:" + " #{company.communication}"
   puts " Bosses:" + " #{company.bosses}"
   puts "Awards:".colorize(:red)
   company.awards.each{|award|puts " #{award}"}
   puts "------------------------------------------------"
  else
   puts "------------------------------------------------"
  end
 end

 def self.custom_list
  puts "------------------------------------------------"
  puts "Please enter your range between 1-100, separated by a dash. For example: 15-20".colorize(:light_blue)
  puts "------------------------------------------------"
  input = gets.strip
  if input.match(/\d{1,}\-\d{1}/)
   input = input.split("-")
   num1 = (input[0].to_i)-1
   num2 = (input[1].to_i)-1
   BestCompanies::Company.list_all(num1,num2)
  else
   puts "------------------------------------------------"
   puts "That's an invalid range"
   self.custom_list
  end
 end
 
end