class BestCompanies::Company
    attr_accessor :name, :industry, :location, :review_url, :challenges, :atmosphere, :rewards, :pride, :communication, :bosses, :awards
    @@all =[]
    
    def initialize(company_hash)
     company_hash.each do |key,value|
      if self.location
       self.location = BestCompanies::Location.new(location)
       puts "#{self.location}"
       self.location = location if self.location
      else
       self.send("#{key}=", value)
       @@all << self
      end
     end
    end
    
    def location=(location)
     @location = location
    
    def self.all
     @@all
    end
        
    def self.create_from_list(company_hash)
     company_hash.each{|company|self.new(company)}
    end
    
    def self.see_list
        list = self.all.collect{|company|company.name}
        list.each{|company|puts "#{company}"}
    end
    
    def self.see_entire_list
        all.each do |company|
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
        end
    end
   
    def add_ratings(ratings_hash)
     ratings_hash.each{|key,value|self.send("#{key}=",value)}
    end
  
    def add_awards(awards_array)
     self.send("awards=",awards_array)
    end
    
    
end