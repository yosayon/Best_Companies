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
 
 def self.all
  @@all
 end
 
 def self.list_all_states
  puts "-------------------------------"
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
  puts "------------------------------------------"
  input = gets.strip
  case input
   when "menu"
    BestCompanies::CLI.ask_user
   when "see states"
    self.list_all_states
   when "exit"
    exit
   else
    self.validate_input(input)
  end
 end
   
 def self.validate_input(input)
  validated_input = self.all.detect{|state|state.name == input}
  if validated_input != nil
   puts "--------------------------"
   validated_input.company.each{|company|puts "#{company}"}
   self.enter_state
  else
   puts "invalid input, please try again."
   self.enter_state
  end
 end
 
end