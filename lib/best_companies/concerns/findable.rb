module Concerns::Findable
    
 module ClassMethods
  def find_by_name(name)
   all.detect{|i|i.name == name}
  end
  
  def find_or_create_by_name(name)
   name = name.split(", ")[1]
  find(name) || create(name)
  end
 end 
 
end