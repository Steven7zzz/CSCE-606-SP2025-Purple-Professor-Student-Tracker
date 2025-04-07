class StatisticsController < ApplicationController
  def index
    @total_students = Student.count

    numeric_grades = Enrollment.all.map { |e| Enrollment.grade_to_numeric(e.grade) }.compact

    @average_grade = numeric_grades.sum / numeric_grades.size.to_f if numeric_grades.any?
    @highest_grade = numeric_grades.max if numeric_grades.any?

    @duplicate_count = Student
      .joins(:enrollments)
      .group(Arel.sql('students.id'))
      .having(Arel.sql('COUNT(DISTINCT enrollments.course_id) > 1'))
      .count
      .size
  end

  def duplicate_students
    @duplicate_students = Student
      .joins(:enrollments)
      .group(Arel.sql('students.id, students.first_name, students.last_name'))
      .having(Arel.sql('COUNT(DISTINCT enrollments.course_id) > 1'))
      .pluck(Arel.sql("students.id, CONCAT(students.first_name, ' ', students.last_name) AS full_name, COUNT(DISTINCT enrollments.course_id) AS class_count"))
  end
end