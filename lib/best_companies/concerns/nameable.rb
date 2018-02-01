module Concerns::Nameable
 
 module ClassMethods
  def create(name)
   self.new(name).tap{|s|s.save}
  end
 end
    
end