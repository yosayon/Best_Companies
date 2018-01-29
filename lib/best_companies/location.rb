class BestCompanies::Location
 attr_accessor :name
 @@all =[]
 
 def initialize(name)
  @name = name
  @company = []
 end  

 def add_company(company)
   @company << company.name unless @company.include?(company.name)
 end
 
 def self.create(name)
 self.new(name).tap{|i|i.save}
 end
 
 def save
 self.class.all << self
 end
 
 def self.find(name)
 all.detect{|i|i.name == name}
 end
 
 def self.find_or_create_by_name(name)
  find(name) || create(name)
 end
 
 def self.all
  @@all
 end
 
end