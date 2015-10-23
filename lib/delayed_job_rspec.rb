require 'delayed_job'
require 'rspec'

require 'delayed/extensions/rspec/version'
require 'delayed/extensions/rspec/job'

RSpec.configure do |config|
  config.before do
    Delayed::Job.reset!
  end
end
