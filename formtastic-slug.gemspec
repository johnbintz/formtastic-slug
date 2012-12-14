# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formtastic-slug/version'

Gem::Specification.new do |gem|
  gem.name          = "formtastic-slug"
  gem.version       = Formtastic::Slug::VERSION
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Add a slug field that can be constructed from another field}
  gem.summary       = %q{Add a slug field that can be constructed from another field}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
