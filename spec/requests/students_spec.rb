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
