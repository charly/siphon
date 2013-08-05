# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'siphon/version'

Gem::Specification.new do |spec|
  spec.name          = "siphon"
  spec.version       = Siphon::VERSION
  spec.authors       = ["Charles Sistovaris"]
  spec.email         = ["charlysisto@gmail.com"]
  spec.description   = %q{Siphon enables you to easily apply/combine/exclude your ActiveRecord scopes with params}
  spec.summary       = %q{Siphon enables you to easily apply/combine/exclude your ActiveRecord scopes with params}
  spec.homepage      = "http://github.com/charly/siphon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  # spec.add_dependency "activesupport"


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
