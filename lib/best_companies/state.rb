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
end