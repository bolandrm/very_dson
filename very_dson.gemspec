$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "very_dson/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "very_dson"
  s.version     = VeryDSON::VERSION
  s.authors     = ["Ryan Boland"]
  s.email       = ["ryan@appcasts.io"]
  s.homepage    = "https://github.com/bolandrm/very_dson"
  s.summary     = "very_dson-#{VeryDSON::VERSION}"
  s.description = "DSON renderer for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "DSON", "~> 0.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
