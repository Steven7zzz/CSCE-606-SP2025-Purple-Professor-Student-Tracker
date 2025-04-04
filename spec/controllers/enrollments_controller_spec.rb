require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:course) do
    Course.find_or_create_by(
      name: 'CSCE',
      number: '100',
      section: '100',
      year: '2025',
      semester: 'Spring'
    )
  end

  let(:student) do
    Student.find_or_create_by(
      first_name: 'John',
      last_name: 'Smith',
      uin: '123456789',
      major: 'Computer Science',
      email: 'johnsmith@tamu.edu'
    )
  end

  let(:valid_attributes) do
    { course_id: course.id, student_id: student.id, grade: 'A' }
  end

  let!(:enrollment) { Enrollment.create!(valid_attributes) }

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
      get :show, params: { id: enrollment.to_param }
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
      get :edit, params: { id: enrollment.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Enrollment' do
        expect do
          post :create, params: { enrollment: valid_attributes }
        end.to change(Enrollment, :count).by(1)
      end

      it 'redirects to the created enrollment' do
        post :create, params: { enrollment: valid_attributes }
        expect(response).to redirect_to(Enrollment.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { grade: 'B' }
      end

      it 'updates the requested enrollment' do
        put :update, params: { id: enrollment.to_param, enrollment: new_attributes }
        enrollment.reload
        expect(enrollment.grade).to eq('B')
      end

      it 'redirects to the enrollment' do
        put :update, params: { id: enrollment.to_param, enrollment: new_attributes }
        expect(response).to redirect_to(enrollment)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested enrollment' do
      expect do
        delete :destroy, params: { id: enrollment.to_param }
      end.to change(Enrollment, :count).by(-1)
    end

    it 'redirects to the enrollments list' do
      delete :destroy, params: { id: enrollment.to_param }
      expect(response).to redirect_to(enrollments_path)
    end
  end
end
