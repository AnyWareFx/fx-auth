# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fx-auth/version'


Gem::Specification.new do |gem|
  gem.name          = 'fx-auth'
  gem.version       = AuthFx::VERSION

  gem.authors       = ['Dave Jackson']
  gem.email         = %w(dave.jackson@anywarefx.com)
  gem.description   = %q{AuthFx - DataMapper models for RESTful Authentication}
  gem.summary       = %q{AuthFx - DataMapper models for RESTful Authentication}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(features|spec|features)/})
  gem.require_paths = %w(lib)

  gem.add_dependency 'data_mapper'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'dm-sqlite-adapter'
end
