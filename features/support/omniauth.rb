require 'omniauth'

Before do
  OmniAuth.config.test_mode = true
end

After do
  OmniAuth.config.test_mode = false
end
