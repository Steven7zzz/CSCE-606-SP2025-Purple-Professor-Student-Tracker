require 'rails_helper'

RSpec.describe 'OmniauthCallbacks', type: :request do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: { email: 'test@example.com' }
    )
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe 'POST /users/auth/google_oauth2/callback' do
    let(:auth_data) { OmniAuth.config.mock_auth[:google_oauth2] }

    before do
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = auth_data
    end

    context 'when user is found' do
      before do
        @user = User.create!(email: 'test@example.com', password: 'password123')
        allow(User).to receive(:from_google).and_return(@user)
      end

      it 'signs in the user and redirects' do
        post user_google_oauth2_omniauth_callback_path

        expect(response).to redirect_to(root_path) # Update with expected path
        follow_redirect!
        expect(response.body).to include('Successfully authenticated from Google account.')
      end
    end

    context 'when user is not found' do
      before do
        allow(User).to receive(:from_google).and_return(nil)
      end

      it 'redirects to sign-in page with alert' do
        post user_google_oauth2_omniauth_callback_path

        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include('Access denied: Your email is not authorized.')
      end
    end
  end

  describe 'GET /users/auth/failure' do
    it 'redirects to sign-in page with an alert' do
      get '/users/auth/failure'

      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response.body).to include('Google authentication failed.')
    end
  end
end
