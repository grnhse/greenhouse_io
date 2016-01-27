# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greenhouse_io/version'

Gem::Specification.new do |spec|
  spec.name          = "greenhouse_io"
  spec.version       = Greenhouse::VERSION
  spec.authors       = ["Adrian Bautista"]
  spec.email         = ["adrianbautista8@gmail.com"]
  spec.description   = %q{A Ruby based wrapper for Greenhouse.io API}
  spec.summary       = %q{A Ruby based wrapper for Greenhouse.io API}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('httmultiparty')
  spec.add_dependency('multi_json', '~>1.11.2')
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "webmock", "~> 1.22.6"
  spec.add_development_dependency "vcr", "~> 3.0.1"
end
