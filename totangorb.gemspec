# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'totangorb/version'

Gem::Specification.new do |spec|
  spec.name          = "totangorb"
  spec.version       = Totangorb::VERSION
  spec.authors       = ["Michał Darda"]
  spec.email         = ["michaldarda@gmail.com"]
  spec.description   = %q{Lightweight Ruby wrapper for Totango.}
  spec.summary       = %q{Lightweight Ruby wrapper for Totango.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
