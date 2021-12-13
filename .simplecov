# vi: ft=ruby

SimpleCov.start do
  enable_coverage  :branch      # Add branch coverage statistics.
  minimum_coverage 90           # Minimum coverage percentage.
  command_name     "test:bdd"   # Must be set for codeclimat reporter
end
