# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'film_on/version'

Gem::Specification.new do |spec|
  spec.name          = "film_on"
  spec.version       = FilmOn::VERSION
  spec.authors       = ["Stuart Hanscombe"]
  spec.email         = ["hanscs1969@yahoo.co.uk"]

  spec.summary       = %q{Ruby wrapper for the FilmOn API}
  spec.description   = %q{Ruby wrapper to initialize connection and call the Film On API services}
  spec.homepage      = "https://github.com/thelazycamel/film_on"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rake_roll"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "httparty"
end
