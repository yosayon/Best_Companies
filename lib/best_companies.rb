#require "best_companies/version"
require 'pry'
require 'nokogiri'
require 'open-uri'

module BestCompanies
  # Your code goes here...
end

require_relative '../lib/best_companies/cli'
require_relative '../lib/best_companies/industry'
require_relative '../lib/best_companies/company'
require_relative '../lib/best_companies/scraper'
require_relative '../lib/best_companies/location'

BestCompanies::CLI.create_list




puts "loading your environment..."
