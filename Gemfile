# frozen_string_literal: true

# Put require=false on gem's that we don't need to import in code (cli exec only)

source "https://rubygems.org"

# Include dependencies from the .gemspec
gemspec

# Development dependencies
# Should rather be here than in the .gemspec
# Reference: https://github.com/rubygems/bundler/pull/7222
# However there's an argument for using gemspec too: https://bundler.io/guides/creating_gem.html#testing-our-gem
group :development, :test do
  gem "appraisal", "~> 2.4", require: false
  gem "gem-release", "~> 2.0", require: false
  gem "rake", "~> 13.0", require: false
  gem "solargraph", require: false
end

group :test do
  gem "json_pure", "~> 2.8", require: false # Solargraph pulls in v2.6.3 which fails build with " uninitialized constant JSON::Fragment"
  gem "rspec", "~> 3.0"
  gem "rubocop", "~> 1.18", require: false
  gem "rubocop-rake", "~> 0.6", require: false
  gem "rubocop-rspec", "~> 3.5", require: false
  gem "simplecov", "~> 0.22"
end
