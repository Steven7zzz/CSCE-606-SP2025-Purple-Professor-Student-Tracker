require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let!(:user) { User.create(email: 'admin@example.com', password: 'password123') }
  let!(:other_user) { User.create(email: 'other@example.com', password: 'password123') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    login_as(user, scope: :user)
  end

  describe 'GET /users' do
    it 'renders the index page with all users' do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/new' do
    it 'renders the new user form' do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users' do
    let(:valid_params) { { user: { email: 'newuser@example.com' } } }
    let(:invalid_params) { { user: { email: 'invalid@example.com', password: 'newpassword' } } }
    let(:empty_email) { { user: { email: '' } } }

    it 'creates a new user with only the permitted parameters' do
      expect {
        post users_path, params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(users_path)
      follow_redirect!
      expect(response.body).to include('User added successfully')
      expect(User.last.email).to eq('newuser@example.com')
    end

    it 'renders the new template if user creation fails' do
      expect {
        post users_path, params: empty_email
      }.not_to change(User, :count) 

      expect(response).to have_http_status(:unprocessable_entity) 
      expect(response.body).to include('Add New User') 
    end

    it 'ignores unpermitted parameters' do
      post users_path, params: invalid_params
      new_user = User.find_by(email: 'invalid@example.com')

      expect(new_user).not_to be_nil
      expect(new_user.valid_password?('newpassword')).to be_falsey 
    end
  end


  describe 'DELETE /users/:id' do
    context 'when deleting another user' do
      it 'removes the user and redirects' do
        delete user_path(other_user)

        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include('User removed successfully.')
        expect(User.exists?(other_user.id)).to be_falsey
      end
    end

    context 'when attempting to delete self' do
      it 'does not delete and redirects with an alert' do
        delete user_path(user)

        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include("You can&#39;t delete yourself!")
        expect(User.exists?(user.id)).to be_truthy
      end
    end
  end

  describe 'Authentication' do
    before do
      sign_out user
    end

    it 'redirects unauthenticated users to sign-in page' do
      get users_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
