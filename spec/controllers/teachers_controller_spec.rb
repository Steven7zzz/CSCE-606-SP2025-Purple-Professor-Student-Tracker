require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  let(:valid_attributes) do
    {
      first_name: "Alice",
      last_name: "Smith",
      uin: "87654321",
      department: "Computer Science",
      course_and_semester: "CSCE 606 - Fall 2025",
      description: "Expert in AI",
      email: "alice.smith@example.com"
    }
  end

  let(:invalid_attributes) do
    { first_name: "", last_name: "", uin: "", department: "", course_and_semester: "", description: "", email: "" }
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Teacher" do
        expect {
          post :create, params: { teacher: valid_attributes }
        }.to change(Teacher, :count).by(1)
      end

      it "redirects to the teachers index page" do
        post :create, params: { teacher: valid_attributes }
        expect(response).to redirect_to(teachers_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Teacher" do
        expect {
          post :create, params: { teacher: invalid_attributes }
        }.to_not change(Teacher, :count)
      end

      it "renders the new template" do
        post :create, params: { teacher: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end
end
