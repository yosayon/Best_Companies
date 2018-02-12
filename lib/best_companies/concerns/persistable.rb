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
   output.each.with_index(1){|v,i|puts "#{i}: #{v.name}".colorize(:red)}
  end
 end
 
  def check_input(input)
   if input.match(/\d{1,}/) && input.to_i.between?(1,self.all.size)
    BestCompanies::self.all.detect{|v|v.name == input}.companies.each{|v|BestCompanies::CLI.see_company(v)}
   end
  end
 
end