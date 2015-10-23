Delayed::Job::RSpec
===================

[![Gem Version](https://badge.fury.io/rb/delayed_job_rspec.svg)](http://badge.fury.io/rb/delayed_job_rspec)
[![Build Status](https://travis-ci.org/dblock/delayed_job_rspec.svg?branch=master)](https://travis-ci.org/dblock/delayed_job_rspec)

Many applications rely on asynchronous behavior of delayed jobs. But having to explicitly invoke `Delayed::Worker.new.work_off` in RSpec tests is tedious. Furthermore jobs fail silently, having to constantly examine delayed jobs for error is annoying.

This gem patches `Delayed::Job` to run jobs immediately under RSpec and warns about failing ones. You can now create expectations from side effects of delayed jobs.

## Installation

Add to Gemfile.

```
group :test do
  gem 'delayed_job_rspec'
end
```

Run `bundle install`.

## Usage

Behavior changes are reset before each spec - the following options will only affect the next example.

### Disable Synchronous Behavior

```ruby
Delayed::Job.execute_asynchronously!
```

### Silence Failure Warnings

```ruby
Delayed::Job.silence_warnings!
```

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2015, [Daniel Doubrovkine](https://twitter.com/dblockdotorg), [Artsy](https://www.artsy.net) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
