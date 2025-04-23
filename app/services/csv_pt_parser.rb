require "csv"

class CsvPtParser
  def self.import(file)
    raise "No file uploaded" unless file

    # Clean BOM or weird line breaks in CSV
    File.open(file.path, "r:bom|utf-8") do |f|
      csv_content = f.read.gsub(/\r/, "").strip
      File.write(file.path, csv_content)
    end

    # Process CSV rows
    CSV.foreach(file.path, headers: true) do |row|
      pt_data = row.to_hash

      # Extract name (assuming format "Last, First")
      last_name, first_name = pt_data["Name"].split(",").map(&:strip)

      # Find or create Peer Teacher
      peer_teacher = PeerTeacher.find_or_create_by(uin: pt_data["UIN"].strip) do |pt|
        pt.first_name = first_name
        pt.last_name = last_name
        pt.email = pt_data["Email"].strip
      end

      # Extract Course Information (Splitting "PHYS 216" into Name and Number)
      course_match = pt_data["Course"].strip.match(/^([A-Za-z]+)\s*(\d+)$/)
      if course_match
        course_name = course_match[1] # "PHYS"
        course_number = course_match[2] # "216"
      else
        raise "Invalid course format: #{pt_data['Course']}"
      end

      # Extract Semester & Year Information (Splitting "Spring 2025")
      semester_match = pt_data["Semester"].strip.match(/^([A-Za-z]+)\s*(\d+)$/)
      if semester_match
        semester = semester_match[1] # "Spring"
        year = semester_match[2] # "2025"
      else
        raise "Invalid semester format: #{pt_data['Semester']}"
      end

      # Find Course (do not create a new one)
      course = Course.find_by(name: course_name, number: course_number, semester: semester, year: year)

      # Check if the course exists but is missing semester or year
      if course.nil?
        raise "Course not match: #{course_name} #{course_number} (#{semester} #{year}) with — Peer Teacher: #{first_name} #{last_name}. Missing year or semester?"
      end
      # Create Enrollment using IDs to ensure efficiency
      PtEnrollment.find_or_create_by(peer_teacher_id: peer_teacher.id, course_id: course.id)
    end
  end
end
