module Persistable
 
 module InstanceMethods
  def save
   self.class.all << self
  end
  
  def add_company(company)
   self.companies << company unless self.companies.include?(company)
  end
  
 end

 module ClassMethods
  def self.extended(base)
   base.class_variable_set(:@@all,[])
  end
  
  def list
   puts "-----------------------------------------"
   output = self.all.sort{|a,b| a.name <=> b.name}
   output.each.with_index(1){|v,i|puts "#{i}: #{i.name}".colorize(:red)}
   BestCompanies::CLI.enter_state_or_industry
  end
 end
 
end