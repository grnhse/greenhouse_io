# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greenhouse_io/version'

Gem::Specification.new do |spec|
  spec.name          = "greenhouse_io"
  spec.version       = GreenhouseIo::VERSION
  spec.authors       = %w(Greenhouse Software)
  spec.email         = %w(tech@greenhouse.io)
  spec.description   = %q{Ruby bindings for the greenhouse.io Harvest API and Job Board API}
  spec.summary       = %q{Ruby bindings for the greenhouse.io Harvest API and Job Board API}
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/grnhse/greenhouse_io"

  spec.post_install_message = %q{
    greenhouse_io will be removed from Rubygems.org on Friday, April 3, 2026.
    Please install using a direct link to the Github repo:
    
    gem "greenhouse_io", git: "git@github.com:grnhse/greenhouse_io.git", branch: "master"

    Additionally, Harvest V1/V2 will be decomissioned in August 2026.
  }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('httmultiparty', '~> 0.3.16')
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "webmock", "~> 1.22.6"
  spec.add_development_dependency "vcr", "~> 3.0.1"
end
