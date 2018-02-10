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
 
 #def self.list_all_industries
 # puts "-----------------------------------------"
 # industries = self.all.sort{|a,b| a.name <=> b.name}
 # industries.each{|s|puts "#{s.name}".colorize(:red)}
 # BestCompanies::CLI.enter_state_or_industry
 #end
 
end