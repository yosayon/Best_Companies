class BestCompanies::Industry
 extend Nameable::ClassMethods
 extend Findable::ClassMethods
 extend Persistable::ClassMethods
 include Persistable::InstanceMethods
 
 attr_accessor :name
  
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