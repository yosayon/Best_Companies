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
  puts "To see the entire list of Best Companies please type ".colorize(:light_blue) + "see list".colorize(:red)
  puts "To enter in a custom range of Best Companies between 1-100, type the range in number-number format. ".colorize(:light_blue) + "For Ex: 15-20".colorize(:red)
  puts "To view the ratings and awards for a company, enter the company rank (1-100) ".colorize(:light_blue) + "For Ex: 5".colorize(:red)
  puts "To view best companies by state or industry, type ".colorize(:light_blue) + "state".colorize(:red) + " or ".colorize(:light_blue) + "industry".colorize(:red)
  puts "To view your saved companies, type ".colorize(:light_blue) + "archive".colorize(:red)
  puts "To exit type ".colorize(:light_blue) + "exit".colorize(:red)
  puts "------------------------------------------------"
  
  input = gets.strip.to_s
  
  case input
   when "see list"
   BestCompanies::Company.list_all(0,99)
  when "state"
   self.enter_state_or_industry
  when "industry"
   self.enter_state_or_industry
  when "archive"
   BestCompanies::Company.archive
  when "exit"
   exit
  else
   self.validate_input(input)
  end
  
  while input != "exit"
    self.ask_user
  end
 end
 
 def self.validate_input(input)
  if input.match(/\d{1,}\-\d{1}/)
   input = input.split("-")
   num1 = (input[0].to_i)
   num2 = (input[1].to_i)
   if num1 < num2 && num1 > 0 && num2.between?(1,100)
    num1 = num1 - 1
    num2 = num2 - 1
    BestCompanies::Company.list_all(num1,num2)
   else
    self.reject_input
   end
  elsif input.match(/\d{1,}/) && input.to_i.between?(1,100)
    if Faraday.get(BestCompanies::Company.all[(input.to_i)-1].review_url).status == 404
     puts "This company does not have a published review".colorize(:light_blue)
     self.see_company(BestCompanies::Company.all[(input.to_i)])
     BestCompanies::Company.all[(input.to_i)-1].save?
     puts "------------------------------------------------"
    else
     self.add_ratings_and_awards(input)
    end
  elsif input.match(/[A-Za-z]/)
   if BestCompanies::State.all.detect{|state|state.name == input} != nil
    BestCompanies::State.all.detect{|state|state.name == input}.companies.each{|company|see_company(company)}
    self.enter_state_or_industry
   elsif BestCompanies::Industry.all.detect{|industry|industry.name == input} != nil
    BestCompanies::Industry.all.detect{|industry|industry.name == input}.companies.each{|company|see_company(company)}
   else
    self.reject_input
   end
  else
   self.reject_input
  end
 end
 
 def self.reject_input
  puts "Your input was rejected. Please type in a valid input.".colorize(:red)
 end
 
 def self.enter_state_or_industry
  input = ""
  puts "------------------------------------------------"
  puts "Please enter the state or industry to view the list of companies".colorize(:light_blue)
  puts "To see the list of states type ".colorize(:light_blue) + "see states".colorize(:red)
  puts "To see the list of industries type ".colorize(:light_blue) + "see industries".colorize(:red)
  puts "Type ".colorize(:light_blue) + "menu".colorize(:red) + ", to go back to the main menu".colorize(:light_blue)
  puts "------------------------------------------------"
  input = gets.strip
  case input
   when "menu"
    self.ask_user
   when "see states"
    BestCompanies::State.list
   when "see industries"
    BestCompanies::Industry.list
   when "exit"
    exit
   else
    self.validate_input(input)
  end
 end
 
 def self.add_ratings_and_awards(input)
  validated_input = BestCompanies::Company.all.detect{|c|c.rank == input}
  validated_input.add_ratings(BestCompanies::Scraper.scrape_ratings(validated_input.review_url))
  validated_input.add_awards(BestCompanies::Scraper.scrape_awards(validated_input.review_url))
  self.see_company(validated_input)
  BestCompanies::Company.all[(input.to_i)-1].save?
  puts "------------------------------------------------"
 end
 
 def self.see_company(company)
  puts "\nRank:".colorize(:red) + " #{company.rank}"
  puts "Name:".colorize(:red) + " #{company.name}"
  puts "Industry:".colorize(:red) + " #{company.industry}"
  puts "Location:".colorize(:red) + " #{company.location}"
  puts "Review_URL:".colorize(:red) + " #{company.review_url}"
  if company.challenges != nil
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
 
end