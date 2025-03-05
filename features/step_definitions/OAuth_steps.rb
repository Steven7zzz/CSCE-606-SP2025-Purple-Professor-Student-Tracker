Given('a user exists with email {string}') do |email|
    User.create!(email: email, password: 'securepassword')
  end
  
  When('the user logs in with Google OAuth using email {string}') do |email|
    auth_data = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: { email: email }
    )
  
    @result = User.from_google(auth_data)
  end
  
  When('the user logs in with Google OAuth using an empty email') do
    malformed_auth = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: { email: nil }
    )
  
    @result = User.from_google(malformed_auth)
  end
  
  Then('the user should be logged in successfully') do
    expect(@result).not_to be_nil
  end
  
  Then('a warning should be logged {string}') do |warning_message|
    expect(Rails.logger).to receive(:warn).with(warning_message)
  end
  
  Then('the login attempt should fail') do
    expect(@result).to be_nil
  end
  