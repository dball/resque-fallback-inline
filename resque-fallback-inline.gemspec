# -*- encoding: utf-8 -*-
require File.expand_path('../lib/resque-fallback-inline/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Donald Ball"]
  gem.email         = ["donald.ball@gmail.com"]
  gem.description   = %q{Resque will fail to enqueue your job if redis is unavailable. Resque-fallback-inline ensures that the job will be run inline if that happens.}
  gem.summary       = %q{Runs your jobs inline if redis is unavailable.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "resque-fallback-inline"
  gem.require_paths = ["lib"]
  gem.version       = Resque::Fallback::Inline::VERSION

  gem.add_dependency('resque', '~> 1.19')
end
