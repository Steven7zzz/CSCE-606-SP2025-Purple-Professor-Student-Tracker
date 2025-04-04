require 'rails_helper'
require 'tempfile'

RSpec.describe CsvParser do
  describe ".import" do
    before do
        Course.destroy_all
        Student.destroy_all
        Enrollment.destroy_all
    end

    let(:csv_content) do
      <<~CSV
        Name,UIN,Major,Email
        "Doe, John",123456789,CS,john.doe@example.com
      CSV
    end

    let(:tempfile) do
      file = Tempfile.new([ 'csce100_100', '.csv' ])
      file.write(csv_content)
      file.rewind
      file
    end

    let(:valid_file) do
      double("file", original_filename: "CSCE100_100_fall_24.csv", path: tempfile.path)
    end

    after do
      tempfile.close
      tempfile.unlink
    end

    it "creates course, student, and enrollment records" do
      expect {
        CsvParser.import(valid_file)
      }.to change(Course, :count).by(1)
       .and change(Student, :count).by(1)
       .and change(Enrollment, :count).by(1)

      course = Course.last
      expect(course.name).to eq("CSCE")
      expect(course.number).to eq("100")
      expect(course.section).to eq("100")
      expect(course.semester).to eq("Fall")
      expect(course.year).to eq("2024")

      student = Student.last
      expect(student.first_name).to eq("John")
      expect(student.last_name).to eq("Doe")
      expect(student.uin).to eq("123456789")
      expect(student.major).to eq("CS")
      expect(student.email).to eq("john.doe@example.com")

      enrollment = Enrollment.last
      expect(enrollment.course).to eq(course)
      expect(enrollment.student).to eq(student)
    end

    context "when filename format is incorrect" do
      let(:invalid_file) { double("file", original_filename: "invalid_filename.csv", path: tempfile.path) }

      it "raises an error" do
        expect { CsvParser.import(invalid_file) }.to raise_error("Filename format is incorrect")
      end
    end
  end
end
