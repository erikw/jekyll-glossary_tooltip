# frozen_string_literal: true

# Run $(rake -T) to list all tasks.

# Include default tasks like build, release, install etc. See https://github.com/rubygems/rubygems/blob/master/bundler/lib/bundler/gem_helper.rb#L46
require "bundler/gem_tasks"

# rspec: Testing framework. Adds 'spec' rake task.
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

# rubocop: Linting. Adds 'rubocop' rake task.
require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop) do |t|
  # See https://docs.rubocop.org/rubocop/usage/basic_usage.html
  t.options = ["--display-cop-names", "--parallel"]
end

desc "Run Qlty code analysis"
task :qlty do
  sh "qlty smells --all"
  sh "qlty metrics --all --max-depth=2 --sort complexity --limit 10"
  # sh "qlty lint" # Just runs rubocop, not necessary as we have a task for this already
end

# default task: Add spec and rubocop to default tasks.
task default: %i[spec rubocop]
