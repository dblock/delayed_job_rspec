$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'rubygems'
require 'rspec'
require 'active_support'
require 'delayed_job'

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end

Delayed::Worker.backend = Delayed::Backend::Test::Job

require 'delayed_job_rspec'
