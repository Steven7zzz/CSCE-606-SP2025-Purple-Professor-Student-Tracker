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

  def per_class_statistics
    valid_grades = ['A', 'B', 'C', 'D', 'F']
    all_enrollments = Enrollment.includes(:course)
  
    @class_statistics = Course.includes(:enrollments).map do |course|
      course_enrollments = course.enrollments
  
      numeric_grades = course_enrollments.map { |e| Enrollment.grade_to_numeric(e.grade) }.compact
      total = course_enrollments.size.nonzero? || 1  # Avoid divide by zero
  
      {
        course_name: "#{course.name}#{course.number}-#{course.section} (#{course.semester} #{course.year})",
        student_count: course_enrollments.size,
        average_grade: numeric_grades.sum / numeric_grades.size.to_f,
        highest_grade: numeric_grades.max,
        f_rate: (course_enrollments.count { |e| e.grade == 'F' } / total.to_f * 100).round(2),
        q_rate: (course_enrollments.count { |e| e.grade == 'Q' } / total.to_f * 100).round(2),
        w_rate: (course_enrollments.count { |e| e.grade == 'W' } / total.to_f * 100).round(2)
      }
    end
  end  
end