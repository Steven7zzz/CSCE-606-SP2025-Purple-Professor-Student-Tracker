require 'rails_helper'

RSpec.describe PeerTeachersController, type: :controller do
  let(:valid_attributes) do
    { first_name: 'John', last_name: 'Smith', uin: '123456789', email: 'johnsmith@tamu.edu' }
  end

  let!(:peer_teacher) { PeerTeacher.create!(valid_attributes) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: peer_teacher.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: peer_teacher.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Peer Teacher' do
        expect do
          post :create, params: { peer_teacher: valid_attributes }
        end.to change(PeerTeacher, :count).by(1)
      end

      it 'redirects to the created peer teacher' do
        post :create, params: { peer_teacher: valid_attributes }
        expect(response).to redirect_to(PeerTeacher.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { first_name: 'Jonathan' }
      end

      it 'updates the requested peer teacher' do
        put :update, params: { id: peer_teacher.to_param, peer_teacher: new_attributes }
        peer_teacher.reload
        expect(peer_teacher.first_name).to eq('Jonathan')
      end

      it 'redirects to the peer teacher' do
        put :update, params: { id: peer_teacher.to_param, peer_teacher: new_attributes }
        expect(response).to redirect_to(peer_teacher)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested peer teacher' do
      expect do
        delete :destroy, params: { id: peer_teacher.to_param }
      end.to change(PeerTeacher, :count).by(-1)
    end

    it 'redirects to the peer teachers list' do
      delete :destroy, params: { id: peer_teacher.to_param }
      expect(response).to redirect_to(peer_teachers_path)
    end
  end
end
