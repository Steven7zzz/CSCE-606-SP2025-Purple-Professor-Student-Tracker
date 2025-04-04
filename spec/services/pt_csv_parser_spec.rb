require 'rails_helper'
require 'tempfile'

RSpec.describe CsvPtParser do
  describe ".import" do
    before do
      PeerTeacher.destroy_all
      Course.destroy_all
      PtEnrollment.destroy_all
    end

    let(:csv_content) do
      <<~CSV
        Name,UIN,Email,Course,Semester
        "Doe, Jane",987654321,jane.doe@example.com,PHYS 216,Spring 2025
      CSV
    end

    let(:tempfile) do
      file = Tempfile.new([ 'pt_import', '.csv' ])
      file.write(csv_content)
      file.rewind
      file
    end

    let(:valid_file) do
      double("file", original_filename: "pt.csv", path: tempfile.path)
    end

    after do
      tempfile.close
      tempfile.unlink
    end

    it "creates peer teacher and pt enrollment records if course exists" do
      course = Course.create!(name: "PHYS", number: "216", semester: "Spring", year: "2025")

      expect {
        CsvPtParser.import(valid_file)
      }.to change(PeerTeacher, :count).by(1)
       .and change(PtEnrollment, :count).by(1)

      pt = PeerTeacher.last
      expect(pt.first_name).to eq("Jane")
      expect(pt.last_name).to eq("Doe")
      expect(pt.uin).to eq("987654321")
      expect(pt.email).to eq("jane.doe@example.com")

      enrollment = PtEnrollment.last
      expect(enrollment.peer_teacher).to eq(pt)
      expect(enrollment.course).to eq(course)
    end

    context "when course does not exist" do
      it "raises an error about course not found" do
        expect {
          CsvPtParser.import(valid_file)
        }.to raise_error("Course not found: PHYS 216. Missing year or semester?")
      end
    end

    context "when course format is invalid" do
      let(:bad_csv_content) do
        <<~CSV
          Name,UIN,Email,Course,Semester
          "Smith, John",123456789,john.smith@example.com,AAA,Spring 2025
        CSV
      end

      let(:bad_tempfile) do
        file = Tempfile.new([ 'bad_format', '.csv' ])
        file.write(bad_csv_content)
        file.rewind
        file
      end

      let(:bad_file) do
        double("file", original_filename: "bad.csv", path: bad_tempfile.path)
      end

      after do
        bad_tempfile.close
        bad_tempfile.unlink
      end


      it "raises an error about invalid course format" do
        expect {
          CsvPtParser.import(bad_file)
        }.to raise_error("Invalid course format: AAA")
      end
    end

    context "when semester format is invalid" do
      let(:bad_semester_content) do
        <<~CSV
          Name,UIN,Email,Course,Semester
          "Smith, John",123456789,john.smith@example.com,PHYS 216,2025Spring
        CSV
      end

      let(:bad_semester_tempfile) do
        file = Tempfile.new([ 'bad_semester', '.csv' ])
        file.write(bad_semester_content)
        file.rewind
        file
      end

      let(:bad_semester_file) do
        double("file", original_filename: "bad_semester.csv", path: bad_semester_tempfile.path)
      end

      after do
        bad_semester_tempfile.close
        bad_semester_tempfile.unlink
      end

      it "raises an error about invalid semester format" do
        expect {
          CsvPtParser.import(bad_semester_file)
        }.to raise_error("Invalid semester format: 2025Spring")
      end
    end

    context "when no file is given" do
      it "raises an error about missing file" do
        expect {
          CsvPtParser.import(nil)
        }.to raise_error("No file uploaded")
      end
    end
  end
end
