
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "best_companies/version"

Gem::Specification.new do |spec|
  spec.name          = "best_companies"
  spec.version       = BestCompanies::VERSION
  spec.authors       = ["Yosa Yon"]
  spec.email         = ["yosa.yon@gmail.com"]

  spec.summary       = "This gem allows users to view the 2017 and 2018 Fortune 100 Best Companies to Work For list"
  spec.description   = "View the 2017 and 2018 Fortune Best Companies to Work For list. Search companies by state and industry and type in the rank of a company to retrieve the employee ratings and awards. Save companies to your archives to view later."
  spec.homepage      = "https://github.com/yosayon/Best_Companies"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "exe"
  spec.executables   << "best_companies"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">= 0"
  spec.add_development_dependency "faraday", "~> 0.14.0"
end
