$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "diag/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "diag"
  s.version     = Diag::VERSION
  s.authors     = ["Senghoo Kim"]
  s.email       = ["shkdmb@gmail.com"]
  s.homepage    = "http://senghoo.com/diag"
  s.summary     = "Summary of Diag."
  s.description = " Description of Diag."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "> 4.0.2"

end
