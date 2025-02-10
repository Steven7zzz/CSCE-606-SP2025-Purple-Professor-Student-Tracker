require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "returns a successful response" do
      student1 = Student.create(first_name: "John", 
      last_name: 'Doe', 
      major: 'Computer Science',
      email: 'john.doe@example.com')

      get students_path

      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.describe "Student", type: :request do
  describe "GET /students/:id" do
    it "returns a successful response" do
      student = Student.create(first_name: "John", 
      last_name: 'Doe', 
      major: 'Computer Science',
      email: 'john.doe@example.com')
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

    let(:invalid_uin_attributes) do
      {
        student: {
          uin: '12345', # Invalid UIN (not 9 characters)
          first_name: 'John',
          last_name: 'Doe',
          major: 'Computer Science',
          email: 'john.doe@example.com'
        }
      }
    end

    let(:invalid_student_attributes) do
      {
        student: {
          uin: '123456789',
          first_name: '',
          last_name: '',
          major: '',
          email: ''
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

    context 'with invalid UIN length' do
      it 'raises an ArgumentError' do
        expect {
          post :create, params: invalid_uin_attributes
        }.to raise_error(ArgumentError, "UIN must be exactly 9 characters long.")
      end
    end


    context 'with invalid student parameters' do
      it 'renders new template with unprocessable_entity status' do
        post :create, params: invalid_student_attributes
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end
end
