class BestCompanies::State
 extend Nameable::ClassMethods
 extend Findable::ClassMethods
 extend Persistable::ClassMethods
 include Persistable::InstanceMethods
 
 attr_accessor :name
 attr_reader :company
 
 def initialize(name)
  @name = name
  @company = []
 end  

 def add_company(company)
  @company << company unless @company.include?(company)
 end
 
 def self.all
  @@all
 end
 
 def self.list_all_states
  binding.pry
  puts "-----------------------------------------"
  states = self.all.sort{|a,b| a.name <=> b.name}
  states.each{|s|puts "#{s.name}".colorize(:red)}
  BestCompanies::CLI.enter_state
 end
 
end