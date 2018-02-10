#require "best_companies/version"
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require 'colorized_string'
require 'faraday'

module BestCompanies
  # Your code goes here...
end

require_relative '../lib/best_companies/concerns/findable'
require_relative '../lib/best_companies/concerns/nameable'
require_relative '../lib/best_companies/concerns/persistable'
require_relative '../lib/best_companies/cli'
require_relative '../lib/best_companies/industry'
require_relative '../lib/best_companies/company'
require_relative '../lib/best_companies/scraper'
require_relative '../lib/best_companies/state'




puts "loading your environment..."

BestCompanies::CLI.start