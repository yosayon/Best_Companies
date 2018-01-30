class BestCompanies::Company
 attr_accessor :rank, :name, :industry, :location, :review_url, :challenges, :atmosphere, :rewards, :pride, :communication, :bosses, :awards
 @@all =[]
    
 def initialize(company_hash)
  company_hash.each do |key,value|
  self.send("#{key}=", value)
  end
  @@all << self
  BestCompanies::Industry.find_or_create_by_name(industry).add_company(self)
  BestCompanies::State.find_or_create_by_name(location).add_company(self)
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
  
 def add_awards(awards_array)
  self.send("awards=",awards_array)
 end
 
end