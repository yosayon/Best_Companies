class BestCompanies::Company
    attr_accessor :name, :industry, :location, :review_url, :challenges, :atmosphere, :rewards, :pride, :communication, :bosses, :awards
    @@all =[]
    
    def initialize(company_hash)
        company_hash.each{|key,value|self.send("#{key}=", value)}
        @@all << self
    end
        
    def self.create_from_list(company_array)
    company_array.each{|company|self.new(company)}
   end
   
   def add_ratings(ratings_hash)
    ratings_hash.each{|key,value|self.send("#{key}=",value)}
  end
  
  def add_awards(awards_hash)
    awards_hash.each{|key,value|self.send("#{key}=",value)}
  end
    
    
end