class BestCompanies::Company
    attr_accessor :name, :industry, :location, :review_url, :challenges, :atmosphere, :rewards, :pride, :communication, :bosses, :awards
    @@all =[]
    
    def initialize(company_hash)
     company_hash.each{|key,value|self.send("#{key}=", value)}
     @@all << self
    end
    
    def self.all
     @@all
    end
        
    def self.create_from_list(company_hash)
     company_hash.each{|company|self.new(company)}
    end
    
    def self.see_list
        list = self.all.collect{|company|company.name}
        list.each{|company| puts "#{company}"}
    end
    
    def self.see_entire_list
        self.all.each{|company| puts "#{company}"}
    end
   
    def add_ratings(ratings_hash)
     ratings_hash.each{|key,value|self.send("#{key}=",value)}
    end
  
    def add_awards(awards_array)
     self.send("#{awards}=",awards_array)
    end
    
    
end