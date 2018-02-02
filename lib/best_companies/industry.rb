class BestCompanies::Industry
 attr_accessor :name
 @@all = []
  
 def initialize(name)
  @name = name
  @company = []
 end
 
 def add_company(company)
  @company << company.name unless @company.include?(company.name)
 end
  
 def self.all
  @@all
 end
 
 def self.list_all_industries
  self.all.each{|industry| puts "Industry: #{industry.name}"}
 end
 
end