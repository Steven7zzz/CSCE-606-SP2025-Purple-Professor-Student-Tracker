require "csv"

class CsvParser
  def self.import(file)
    course_info = file.original_filename.match(/([a-zA-Z]+)(\d+)_(\d+)\.csv/)
    if course_info
        @course = Course.find_or_create_by(name: course_info[1].upcase, number: course_info[2], section: course_info[3])
    else
        raise "Filename format is incorrect"
    end

    File.open(file.path, "r:bom|utf-8") do |f|
      csv_content = f.read.gsub(/\r/, "").strip
      File.write(file.path, csv_content)
    end
    
    CSV.foreach(file.path, headers: true) do |row|
      student_data = row.to_hash
      name = student_data["Name"]
      student_last_name, student_first_name = name.split(",").map(&:strip)
      cur_student = Student.find_or_create_by(first_name: student_first_name, last_name: student_last_name, uin: student_data["UIN"], major: student_data["Major"], email: student_data["Email"])
      Enrollment.find_or_create_by(course: @course, student: cur_student)
    end
  end
end
