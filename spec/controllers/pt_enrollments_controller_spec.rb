require 'rails_helper'

RSpec.describe PtEnrollmentsController, type: :controller do
  let(:course) do
    Course.create!(
      name: 'CSCE',
      number: '100',
      section: '100',
      year: '2025',
      semester: 'Spring'
    )
  end

  let(:peer_teacher) do
    PeerTeacher.create!(
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

  describe 'POST #create' do
    it 'creates a new PtEnrollment and redirects' do
      expect {
        post :create, params: { pt_enrollment: valid_attributes }
      }.to change(PtEnrollment, :count).by(1)

      expect(response).to redirect_to(PtEnrollment.last)
      expect(flash[:notice]).to eq("Pt enrollment was successfully created.")
    end
  end

  describe 'PATCH #update' do
    let(:new_peer_teacher) do
      PeerTeacher.create!(
        first_name: 'Alice',
        last_name: 'Johnson',
        uin: '987654321',
        email: 'alice@tamu.edu'
      )
    end

    it 'updates the requested pt_enrollment and redirects' do
      patch :update, params: {
        id: pt_enrollment.to_param,
        pt_enrollment: { peer_teacher_id: new_peer_teacher.id }
      }

      pt_enrollment.reload
      expect(pt_enrollment.peer_teacher_id).to eq(new_peer_teacher.id)
      expect(response).to redirect_to(pt_enrollment)
      expect(flash[:notice]).to eq("Pt enrollment was successfully updated.")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pt enrollment' do
      expect {
        delete :destroy, params: { id: pt_enrollment.to_param }
      }.to change(PtEnrollment, :count).by(-1)
    end

    it 'redirects to the pt enrollments list with notice' do
      delete :destroy, params: { id: pt_enrollment.to_param }
      expect(response).to redirect_to(pt_enrollments_path)
      expect(flash[:notice]).to eq("Pt enrollment was successfully destroyed.")
    end
  end

  describe 'POST #import' do
    let(:csv_content) do
      <<~CSV
        Name,UIN,Email,Course,Semester
        "Smith, John",123456789,johnsmith@tamu.edu,CSCE 100,Spring 2025
      CSV
    end

    let(:tempfile) do
      file = Tempfile.new([ 'pt', '.csv' ])
      file.write(csv_content)
      file.rewind
      file
    end

    let(:uploaded_file) do
      ActionDispatch::Http::UploadedFile.new(
        filename: "CSCE100_100.csv",
        type: "text/csv",
        tempfile: tempfile
      )
    end

    after do
      tempfile.close
      tempfile.unlink
    end

    it 'calls CsvPtParser.import and redirects with notice' do
      allow(CsvPtParser).to receive(:import)

      post :import, params: { file: uploaded_file }

      expect(CsvPtParser).to have_received(:import)
      expect(response).to redirect_to(pt_enrollments_path)
      expect(flash[:notice]).to eq("CSV successfully imported!")
    end

    it 'shows alert if CsvPtParser raises error' do
      allow(CsvPtParser).to receive(:import).and_raise("Something went wrong")

      post :import, params: { file: uploaded_file }

      expect(response).to redirect_to(pt_enrollments_path)
      expect(flash[:alert]).to include("Error: Something went wrong")
    end
  end
end
