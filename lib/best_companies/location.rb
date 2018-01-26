class BestCompanies::Location
 attr_accessor :state
 @@all =[]
    
 def initialize(state)
  @state = state
  @@all << self
  @companies = []
 end
 
 def add_company(company)
  @company << self
 end
 
 def self.all
  @@all
 end
end