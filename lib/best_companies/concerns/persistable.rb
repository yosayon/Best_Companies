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
 end
 
end