require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:valid_attributes) do
    { name: 'CSCE', number: '100', section: '100', year: '2025', semester: 'Spring' }
  end

  let!(:course) { Course.create!(valid_attributes) }

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
      get :show, params: { id: course.to_param }
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
      get :edit, params: { id: course.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Course' do
        expect do
          post :create, params: { course: valid_attributes }
        end.to change(Course, :count).by(1)
      end

      it 'redirects to the created course' do
        post :create, params: { course: valid_attributes }
        expect(response).to redirect_to(Course.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'ECEN' }
      end

      it 'updates the requested course' do
        put :update, params: { id: course.to_param, course: new_attributes }
        course.reload
        expect(course.name).to eq('ECEN')
      end

      it 'redirects to the course' do
        put :update, params: { id: course.to_param, course: new_attributes }
        expect(response).to redirect_to(course)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course' do
      expect do
        delete :destroy, params: { id: course.to_param }
      end.to change(Course, :count).by(-1)
    end

    it 'redirects to the courses list' do
      delete :destroy, params: { id: course.to_param }
      expect(response).to redirect_to(courses_path)
    end
  end
end
