require 'csv'

class StudentRoster < ApplicationRecord
  def self.import(file)

    roster_name = File.basename(file.original_filename, ".csv").strip  # Extract filename

    CSV.foreach(file.path, headers: true, liberal_parsing: true, encoding: "bom|utf-8") do |row|
      # Normalize headers: Strip whitespace and replace newline characters
      student_data = row.to_hash.transform_keys { |key| key.to_s.strip.gsub(/\s+/, " ") }

      puts student_data  # Debugging: See the formatted output

      StudentRoster.find_or_create_by!(uin: student_data["UIN"]) do |student|
        student.name = student_data["Name"]
        student.major = student_data["Major"]
        student.class_level = student_data["Class"]
        student.email = student_data["Email"]
        # Generate fake grades if Final is missing
        student.final ||= student_data["Final"].to_s.strip.presence || rand(60..100)
        student.roster_name = roster_name
      end
    end
  end
end