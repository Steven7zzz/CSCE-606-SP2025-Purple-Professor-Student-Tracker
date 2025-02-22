require 'capybara/rspec'

Capybara.default_driver = :selenium_chrome_headless
Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.include Capybara::DSL
end
