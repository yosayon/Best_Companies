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
 
  def check_input(input)
   if input.match(/\d{1,}/) && input.to_i.between?(1,self.all.size)
    self.all.sort{|a,b| a.name <=> b.name}[(input.to_i)-1].companies.each{|v|BestCompanies::CLI.see_company(v)}
   elsif input == "menu"
   BestCompanies::CLI.ask_user
   else
    BestCompanies::CLI.reject_input
    self.check_input(BestCompanies::CLI.get_input)
   end
  end
 end
 
end