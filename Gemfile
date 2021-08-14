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
  gem "travis", "~> 1.0", require: false
end

group :test do
  gem "rspec", "~> 3.0"
  gem "rubocop", "~> 1.18", require: false
  gem "rubocop-rake", "~> 0.6", require: false
  gem "rubocop-rspec", "~> 2.4", require: false
  gem "simplecov", "~> 0.21"
end
