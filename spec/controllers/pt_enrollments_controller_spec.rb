require 'rails_helper'

RSpec.describe PtEnrollmentsController, type: :controller do
  let(:course) do
    Course.find_or_create_by(
      name: 'CSCE', 
      number: '100', 
      section: '100', 
      year: '2025', 
      semester: 'Spring'
    )
  end
  
  let(:peer_teacher) do
    PeerTeacher.find_or_create_by(
      first_name: 'John', 
      last_name: 'Smith', 
      uin: '123456789', 
      email: 'johnsmith@tamu.edu'
    )
  end

  let(:valid_attributes) do
    { course_id: course.id, peer_teacher_id: peer_teacher.id }
  end

  let!(:pt_enrollment) { PtEnrollment.create!(valid_attributes) }

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
      get :show, params: { id: pt_enrollment.to_param }
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
      get :edit, params: { id: pt_enrollment.to_param }
      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pt enrollment' do
      expect do
        delete :destroy, params: { id: pt_enrollment.to_param }
      end.to change(PtEnrollment, :count).by(-1)
    end

    it 'redirects to the pt enrollments list' do
      delete :destroy, params: { id: pt_enrollment.to_param }
      expect(response).to redirect_to(pt_enrollments_path)
    end
  end
end
