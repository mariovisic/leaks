# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'leaks/version'

Gem::Specification.new do |gem|
  gem.name          = "leaks"
  gem.version       = Leaks::VERSION
  gem.authors       = ["Mario Visic"]
  gem.email         = ["mario@mariovisic.com"]
  gem.description   = %q{Leaks loops your rpsec tests and monitors process RAM usage to detect any memory leaks. Processes with continiously growing usage could protentially have a leak in them.}
  gem.summary       = %q{Find memory leaks using your rspec tests}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_runtime_dependency 'rspec-core', '~> 2.0'
end
