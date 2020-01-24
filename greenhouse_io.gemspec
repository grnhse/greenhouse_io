# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greenhouse_io/version'

Gem::Specification.new do |spec|
  spec.name          = "greenhouse_io"
  spec.version       = GreenhouseIo::VERSION
  spec.authors       = ["Greenhouse Software", "Adrian Bautista"]
  spec.email         = ["support@greenhouse.io", "adrianbautista8@gmail.com"]
  spec.description   = %q{Ruby bindings for the greenhouse.io Harvest API and Job Board API}
  spec.summary       = %q{Ruby bindings for the greenhouse.io Harvest API and Job Board API}
  spec.license       = "MIT"
  #spec.homepage      = "https://github.com/grnhse/greenhouse_io"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('httparty', '~> 0.17')
  spec.add_dependency('oj', '~> 3.0')
  spec.add_dependency('activesupport', '>= 5.2')
  spec.required_ruby_version = '>= 2.6.5'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.8.0"
  spec.add_development_dependency "webmock", "~> 1.22.6"
  spec.add_development_dependency "vcr", "~> 3.0.3"
end
