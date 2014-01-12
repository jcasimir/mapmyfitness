# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapmyfitness/version'

Gem::Specification.new do |spec|
  spec.name          = "mapmyfitness"
  spec.version       = MapMyFitness::VERSION
  spec.authors       = ["Jeff Casimir"]
  spec.email         = ["jeff@casimircreative.com"]
  spec.description   = "A Ruby wrapper gem for the MapMyFitness API"
  spec.summary       = "Based on the v7 API using OAuth2"
  spec.homepage      = "http://github.com/jcasimir/mapmyfitness"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0"
end
