class BestCompanies::State
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
 
 #def self.list_all_states
 # puts "-----------------------------------------"
 # states = self.all.sort{|a,b| a.name <=> b.name}
 # states.each{|s|puts "#{s.name}".colorize(:red)}
 # BestCompanies::CLI.enter_state_or_industry
 #end
 
end