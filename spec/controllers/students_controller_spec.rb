require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:valid_attributes) do
    { first_name: 'John', last_name: 'Smith', uin: '123456789', major: 'Computer Science', email: 'johnsmith@tamu.edu' }
  end

  let!(:student) { Student.create!(valid_attributes) }

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
      get :show, params: { id: student.to_param }
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
      get :edit, params: { id: student.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Student' do
        expect do
          post :create, params: { student: valid_attributes }
        end.to change(Student, :count).by(1)
      end

      it 'redirects to the created student' do
        post :create, params: { student: valid_attributes }
        expect(response).to redirect_to(Student.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { first_name: 'Jonathan' }
      end

      it 'updates the requested student' do
        put :update, params: { id: student.to_param, student: new_attributes }
        student.reload
        expect(student.first_name).to eq('Jonathan')
      end

      it 'redirects to the student' do
        put :update, params: { id: student.to_param, student: new_attributes }
        expect(response).to redirect_to(student)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested student' do
      expect do
        delete :destroy, params: { id: student.to_param }
      end.to change(Student, :count).by(-1)
    end

    it 'redirects to the students list' do
      delete :destroy, params: { id: student.to_param }
      expect(response).to redirect_to(students_path)
    end
  end
end
