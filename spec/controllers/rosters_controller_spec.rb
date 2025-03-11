require 'rails_helper'

RSpec.describe RostersController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    Course.destroy_all
    Student.destroy_all
    Enrollment.destroy_all
  end

  describe "POST import" do
    context "when file is not provided" do
      it "sets a flash alert and redirects to rosters_path" do
        post :import, params: {}
        
        expect(flash[:alert]).to eq("Please upload a valid CSV file.")
        expect(response).to redirect_to(rosters_path)
      end
    end
  end

  describe "GET show" do
    let!(:course) { Course.create!(name: "CSCE", number: "100", section: "100") }
    let!(:student1) { Student.create!(first_name: "John", last_name: "Doe", uin: "123456789", major: "CS", email: "john.doe@example.com") }
    let!(:student2) { Student.create!(first_name: "Alice", last_name: "Smith", uin: "987654321", major: "CS", email: "alice.smith@example.com") }

    before do
      Enrollment.create!(course: course, student: student1)
      Enrollment.create!(course: course, student: student2)
    end

    context "with valid sort and order parameters" do
      it "sets session values and assigns sorted course students" do
        get :show, params: { id: course.id, sort: "last_name", order: "desc" }
        
        expect(assigns(:sort)).to eq("last_name")
        expect(assigns(:order)).to eq("desc")
        expect(session[:sort]).to eq("last_name")
        expect(session[:order]).to eq("desc")
        expect(assigns(:course_students)).to eq(course.students.order("last_name desc"))
      end
    end

    context "with invalid sort and order parameters" do
      it "defaults to first_name and asc ordering" do
        get :show, params: { id: course.id, sort: "invalid", order: "invalid" }
        
        # Defaults should fall back to first_name and asc
        expect(assigns(:sort)).to eq("first_name")
        expect(assigns(:order)).to eq("asc")
        expect(session[:sort]).to eq("first_name")
        expect(session[:order]).to eq("asc")
        expect(assigns(:course_students)).to eq(course.students.order("first_name asc"))
      end
    end
  end
end
