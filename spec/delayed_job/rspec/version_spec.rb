require 'spec_helper'

describe DelayedJob::RSpec do
  it 'has a version' do
    expect(subject::VERSION).to_not be nil
  end
end
