# coding: utf-8

Gem::Specification.new do |spec|

  spec.name          = "mongoid-crud"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = "four method to rule them all! Use crud methods on mongoid classes to do anything. Super easy to use! Work even on deeply embedded models"
  spec.summary       = "CRUD on any mongoid model"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "mongoid-dsl", ">= 1.0.1"

end
