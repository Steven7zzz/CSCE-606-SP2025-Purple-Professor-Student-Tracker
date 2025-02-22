require 'rails_helper'
require 'csv'

RSpec.describe StudentRoster, type: :model do
  describe ".import" do
    let(:file) { fixture_file_upload("test_roster.csv", "text/csv") }

    before do
      # Ensure the test database is clean before each run
      StudentRoster.destroy_all
    end

    it "imports students correctly from CSV" do
      expect {
        StudentRoster.import(file)
      }.to change { StudentRoster.count }.by(22) # There are 22 students in the CSV

      student = StudentRoster.find_by(uin: "235003660")
      expect(student).to have_attributes(
        name: "Agnihotri, Siyona",
        major: "TEAB",
        class_level: "U1",
        email: "siyonaagni@email.tamu.edu"
      )
      expect(student.final).to be_between(60, 100) # Randomly assigned if missing
    end

    it "does not create duplicate students if UIN already exists" do
      StudentRoster.create!(
        uin: "235003660",
        name: "Existing Student",
        major: "Math",
        class_level: "Freshman",
        email: "existing@example.com",
        final: 80
      )

      expect {
        StudentRoster.import(file)
      }.to change { StudentRoster.count }.by(21) # 22 students in CSV but 1 already exists

      existing_student = StudentRoster.find_by(uin: "235003660")
      expect(existing_student.name).to eq("Existing Student") # Should not overwrite existing record
    end
  end
end
