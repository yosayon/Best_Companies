class BestCompanies::Company
 attr_accessor :rank, :name, :industry, :location, :review_url, :challenges, :atmosphere, :rewards, :pride, :communication, :bosses, :awards
 @@all =[]
 @@archive =[]
    
 def initialize(company_hash)
  company_hash.each do |key,value|
  self.send("#{key}=", value)
  end
  @@all << self
  BestCompanies::Industry.find_or_create_by_name(industry).add_company(self)
  BestCompanies::State.find_or_create_by_name(location.split(", ")[1]).add_company(self)
 end
    
 def self.all
  @@all
 end
    
 def self.create_from_list(company_hash)
  company_hash.each do |company|
  self.new(company)
  end
 end
 
 def self.see_list
  list = self.all.collect{|company|company.name}
  list.each{|company|puts "#{company}"}
 end
   
 def add_ratings(ratings_hash)
  ratings_hash.each{|key,value|self.send("#{key}=",value)}
 end
 
 def self.list_all(num1=0,num2=99)
  puts "------------------------------------------------"
  self.all.slice(num1..num2).each do |company|
   puts "#{company.rank}: #{company.name}"
  end
  puts "------------------------------------------------"
 end
  
 def add_awards(awards_array)
  self.send("awards=",awards_array)
 end
 
 def save?
  puts "Would you like to save this company into your archives? Type y or n".colorize(:light_blue)
  input = gets.strip
  if input == "y" || input == "Y"
   if @@archive.include?(self)
    puts "This company is already saved in your archives."
   else
    @@archive << self
    puts "This company has been saved to your archives!".colorize(:light_blue)
    puts "------------------------------------------------"
   end
  else
   puts "You chose not to save this company".colorize(:light_blue)
  end
 end
 
 def self.archive
  @@archive.each{|company|BestCompanies::CLI.see_company(company)}
 end
 
end