class BestCompanies::Industry
 extend Nameable::ClassMethods
 extend Findable::ClassMethods
 extend Persistable::ClassMethods
 include Persistable::InstanceMethods
 
 attr_accessor :name
 attr_reader :companies
  
 def initialize(name)
  @name = name
  @companies = []
 end
  
 def self.all
  @@all
 end
 
 def self.list_all_industries
  self.all.each{|industry| puts "Industry: #{industry.name}"}
 end
 
end