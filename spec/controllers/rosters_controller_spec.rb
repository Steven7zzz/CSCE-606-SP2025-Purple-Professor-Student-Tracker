require 'rails_helper'

RSpec.describe RostersController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    Course.destroy_all
    Student.destroy_all
    Enrollment.destroy_all
  end

  describe "GET #index" do
    it "assigns all courses to @rosters" do
      course1 = Course.create!(name: "CSCE", number: "100", section: "100")
      course2 = Course.create!(name: "PHYS", number: "216", section: "500")

      get :index

      expect(assigns(:rosters)).to match_array([course1, course2])
      expect(response).to render_template(:index)
    end
  end

  describe "POST #import" do
    context "when file is not provided" do
      it "sets a flash alert and redirects to courses_path" do
        post :import, params: {}

        expect(flash[:alert]).to eq("Please upload a valid CSV file.")
        expect(response).to redirect_to(courses_path)
      end
    end

    context "when a valid file is provided" do
      let(:csv_content) do
        <<~CSV
          Name,UIN,Major,Email
          "Doe, John",123456789,CS,john.doe@example.com
        CSV
      end
    
      let(:tempfile) do
        file = Tempfile.new(['CSCE100_100', '.csv'])
        file.write(csv_content)
        file.rewind
        file
      end
    
      let(:valid_file) do
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
    
      it "calls CsvParser.import and sets success flash" do
        allow(CsvParser).to receive(:import)
    
        post :import, params: { file: valid_file }
    
        expect(CsvParser).to have_received(:import)
        expect(flash[:notice]).to eq("CSV imported successfully!")
        expect(response).to redirect_to(courses_path)
      end
    end    
  end


  describe "GET #show" do
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

        expect(assigns(:sort)).to eq("first_name")
        expect(assigns(:order)).to eq("asc")
        expect(session[:sort]).to eq("first_name")
        expect(session[:order]).to eq("asc")
        expect(assigns(:course_students)).to eq(course.students.order("first_name asc"))
      end
    end
  end
end
