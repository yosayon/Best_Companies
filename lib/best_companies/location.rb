class BestCompanies::Location
 attr_accessor :state
 @@all =[]
    
 def initialize(state)
  @state = state
  @@all << self
 end
 
 def self.all
  @@all
 end
end