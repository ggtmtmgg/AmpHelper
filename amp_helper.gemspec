# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amp_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'amp_helper'
  spec.version       = AmpHelper::VERSION
  spec.authors     = ['Awjecc']
  spec.email       = ['awjecc@gmail.com']

  spec.summary     = 'AmpHelper provides extra view helpers.'
  spec.homepage    = 'http://awjecc.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_dependency 'rails', '~> 4.1.8'
  spec.add_dependency 'fastimage', '~> 2.0.1'
  spec.add_dependency 'carrierwave', '~> 1.0.0.rc'
end
