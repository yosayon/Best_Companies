class BestCompanies::State
 attr_accessor :name
 @@all = []
 
 def initialize(name)
  @name = name
  @company = []
 end  

 def add_company(company)
   @company << company.name unless @company.include?(company.name)
 end
 
 def self.create(name)
 self.new(name).tap{|i|i.save}
 end
 
 def save
 self.class.all << self
 end
 
 def self.find(name)
 all.detect{|i|i.name == name}
 end
 
 def self.find_or_create_by_name(name)
  state = name.split(", ")[1]
  find(state) || create(state)
 end
 
 def self.all
  @@all
 end
 
 def self.list_all_states
  self.all.each{|state|puts "#{state.name}"}
 end
 
end