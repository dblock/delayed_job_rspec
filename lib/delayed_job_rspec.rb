require 'delayed_job'
require 'rspec'

require_relative 'delayed/extensions/rspec/version'
require_relative 'delayed/backend/base'

RSpec.configure do |config|
  config.before do
    Delayed::Job.reset!
  end
end
