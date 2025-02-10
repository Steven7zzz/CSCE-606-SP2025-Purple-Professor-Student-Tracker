require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "returns a successful response" do
      student1 = Student.create(first_name: "John Doe")
      student2 = Student.create(first_name: "Jane Doe")

      get students_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("John Doe", "Jane Doe")
    end
  end
end

RSpec.describe "Student", type: :request do
  describe "GET /students/:id" do
    it "returns a successful response" do
      student = Student.create(first_name: "John Doe")
      get student_path(student)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(student.first_name)
    end
  end
end

RSpec.describe "StudentsNew", type: :request do
  describe "GET /students/new" do
    it "returns a successful response" do
      get new_student_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.describe StudentsController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      {
        student: {
          uin: '123456789',
          first_name: 'John',
          last_name: 'Doe',
          major: 'Computer Science',
          email: 'john.doe@example.com'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new Student' do
        expect {
          post :create, params: valid_attributes
        }.to change(Student, :count).by(1)
      end

      it 'redirects to the created student' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(Student.last)
      end
    end
  end
end