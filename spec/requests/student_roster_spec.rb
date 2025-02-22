require 'rails_helper'

RSpec.describe "StudentRosters", type: :request do
  let!(:roster) { StudentRoster.create(roster_name: "Fall 2025", name: "John Doe", uin: "123456789", major: "CS", class_level: "Senior", email: "john@example.com", final: false) }

  describe "GET /index" do
    it "returns a success response and lists unique rosters" do
      get student_rosters_path
      expect(response).to have_http_status(:success)
      expect(assigns(:rosters)).to include("Fall 2025")
    end
  end

  describe "GET /show" do
    it "returns students for the given roster" do
      get student_roster_path("Fall 2025")
      expect(response).to have_http_status(:success)
      expect(assigns(:students)).to include(roster)
    end
  end

  describe "POST /import" do
    let(:csv_file) { fixture_file_upload('test_roster.csv', 'text/csv') }

    it "imports students from CSV" do
      allow(StudentRoster).to receive(:import).and_return(true)

      post import_student_rosters_path, params: { file: csv_file }
      expect(response).to redirect_to(student_rosters_path)
      expect(flash[:notice]).to eq("CSV imported successfully!")
    end

    it "shows an error when no file is uploaded" do
      post import_student_rosters_path
      expect(response).to redirect_to(student_rosters_path)
      expect(flash[:alert]).to eq("Please upload a valid CSV file.")
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      get new_student_roster_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { student_roster: { roster_name: "Spring 2025", name: "Jane Doe", uin: "987654321", major: "IT", class_level: "Junior", email: "jane@example.com", final: false } } }
    let(:invalid_attributes) { { student_roster: { roster_name: "", name: "", uin: "", major: "", class_level: "", email: "", final: false } } }

    it "creates a new student roster" do
      expect {
        post student_rosters_path, params: valid_attributes
      }.to change(StudentRoster, :count).by(1)

      expect(response).to redirect_to(StudentRoster.last)
      expect(flash[:notice]).to eq("Student roster was successfully created.")
    end
  end

  describe "PATCH /update" do
    let(:update_attributes) { { student_roster: { name: "Updated Name" } } }

    it "updates the student roster" do
      patch student_roster_path(roster.roster_name), params: update_attributes
      roster.reload

      expect(response).to redirect_to(student_roster_path(roster))
      expect(roster.name).to eq("Updated Name")
    end
  end

  describe "DELETE /destroy" do
    it "deletes the student roster" do
      expect {
        delete student_roster_path(roster.roster_name)
      }.to change(StudentRoster, :count).by(-1)

      expect(response).to redirect_to(student_rosters_path)
      expect(flash[:notice]).to eq("Student roster was successfully destroyed.")
    end
  end
end
