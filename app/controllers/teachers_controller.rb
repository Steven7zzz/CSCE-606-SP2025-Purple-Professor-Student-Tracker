require 'csv'

class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all  # get all the teachers data
  end

  def import
    if params[:file].present?
      begin
        CSV.foreach(params[:file].path, headers: true) do |row|
          teacher = Teacher.find_or_initialize_by(uin: row["UIN"]) # void repeating
          teacher.update!(
            first_name: row["First Name"],
            last_name: row["Last Name"],
            department: row["Department"],
            course_and_semester: row["Course and Semester"],
            description: row["Description"]
          )
        end
        redirect_to teachers_path, notice: "CSV imported successfully"
      rescue => e
        redirect_to teachers_path, alert: "CSV fails: #{e.message}"
      end
    else
      redirect_to teachers_path, alert: "please upload CSV"
    end
  end
end

