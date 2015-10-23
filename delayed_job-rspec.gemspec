$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'delayed_job/rspec/version'

Gem::Specification.new do |s|
  s.name = 'delayed_job-rspec'
  s.version = DelayedJob::RSpec::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/delayed_job-rspec'
  s.licenses = ['MIT']
  s.summary = 'Run delayed jobs synchronously under RSpec.'
  s.add_dependency 'delayed_job'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop', '0.34.1'
end
