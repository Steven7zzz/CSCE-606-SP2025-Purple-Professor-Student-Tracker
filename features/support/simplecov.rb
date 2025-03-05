require 'simplecov'

SimpleCov.start do
  add_filter 'features/' # Exclude feature files from coverage
  add_filter 'spec/' # Exclude RSpec tests

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
end

# Ensure the coverage only starts when running Cucumber
SimpleCov.command_name 'Cucumber'
