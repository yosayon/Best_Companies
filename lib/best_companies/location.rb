class BestCompanies::Location
 attr_accessor :location, :company
 @@all =[]
    
 def initialize(location)
  @location = location
  @@all << self
  @companies = []
 end
 
 def add_company(company)
 self.companies << company unless companies.include?(company)
 end
 
 def self.all
  @@all
 end
end