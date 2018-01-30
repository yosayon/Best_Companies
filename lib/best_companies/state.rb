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
  input = ""
  states = self.all.sort{|a,b| a.name <=> b.name}
  states.each{|state|puts "#{state.name}"}
  puts "-----------------------------------------"
  puts "Please enter the state to view the list of companies"
  puts "Type menu, to go back to the main menu"
  input = gets.strip
  
  case input
   when self.find(input)
   self.all.detect{|state|state.name == input}
   when "menu"
   BestCompanies::CLI.start
   else
   self.list_all_states
   end
  end
 
end