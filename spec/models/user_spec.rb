require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_google' do
    let(:auth_data) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456789',
        info: { email: 'authorized@example.com' }
      )
    end

    context 'when user exists' do
      before do
        @user = User.create!(email: 'authorized@example.com', password: 'securepassword')
      end

      it 'returns the existing user' do
        result = User.from_google(auth_data)
        expect(result).to eq(@user)
      end
    end

    context 'when user does not exist' do
      it 'returns nil and logs a warning' do
        expect(Rails.logger).to receive(:warn).with("Unauthorized login attempt for unauthorized@example.com")

        auth_data.info.email = 'unauthorized@example.com' # Modify auth_data to use an unknown email
        result = User.from_google(auth_data)

        expect(result).to be_nil
      end
    end

    context 'when auth data is malformed' do
      it 'returns nil and logs a warning' do
        expect(Rails.logger).to receive(:warn).with("Unauthorized login attempt for ")

        malformed_auth = OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '123456789', info: { email: nil })
        result = User.from_google(malformed_auth)

        expect(result).to be_nil
      end
    end
  end
end
