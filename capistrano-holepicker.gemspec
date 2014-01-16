# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/holepicker/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-holepicker"
  spec.version       = Capistrano::Holepicker::VERSION
  spec.authors       = ["Chris Beer"]
  spec.email         = ["cabeer@stanford.edu"]
  spec.summary       = %q{Capistrano/Holepicker integration for checking dependencies for vulnerabilities}
  spec.homepage      = ""
  spec.license       = "APACHE2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.0"
  spec.add_dependency "holepicker"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
