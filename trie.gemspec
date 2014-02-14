# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trie/version'

Gem::Specification.new do |spec|
  spec.name          = "trie"
  spec.version       = Trie::VERSION
  spec.authors       = ["CLR"]
  spec.email         = ["clr@port49.com"]
  spec.summary       = %q{Implements an autocomplete library using a C-Trie.}
  spec.description   = %q{See the README.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
