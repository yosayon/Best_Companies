class BestCompanies::State
 attr_accessor :name
 attr_reader :company
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
  states = self.all.sort{|a,b| a.name <=> b.name}
  states.each{|s|puts "#{s.name}"}
  self.enter_state
 end
 
 def self.enter_state
  input = ""
  puts "-----------------------------------------"
  puts "Please enter the state to view the list of companies"
  puts "To see the list of states again type 'see states'"
  puts "Type menu, to go back to the main menu"
  input = gets.strip
  
  validate_input = self.all.detect{|state|state.name == input}
  
  if input == "menu"
   BestCompanies::CLI.ask_user
  elsif input == "see states"
   self.list_all_states
  elsif validate_input.name != nil
    puts "#{validate_input.company}"
    self.enter_state
  else
   puts "That's not a valid input. Please try again."
   self.list_all_states
  end
 end
 
end
 
