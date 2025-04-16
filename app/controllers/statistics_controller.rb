class StatisticsController < ApplicationController
  def index
    @total_students = Student.count

    # Exclude N/A grades from numeric calculations
    numeric_grades = Enrollment.all
      .map { |e| Enrollment.grade_to_numeric(e.grade) }
      .compact

    @average_grade = numeric_grades.sum / numeric_grades.size.to_f if numeric_grades.any?
    @highest_grade = numeric_grades.max if numeric_grades.any?

    @duplicate_count = Student
      .joins(:enrollments)
      .group(Arel.sql('students.id'))
      .having(Arel.sql('COUNT(DISTINCT enrollments.course_id) > 1'))
      .count
      .size

    @na_count = Enrollment.where(grade: 'N/A').count
  end

  def duplicate_students
    @duplicate_students = Student
      .joins(:enrollments)
      .group(Arel.sql('students.id, students.first_name, students.last_name'))
      .having(Arel.sql('COUNT(DISTINCT enrollments.course_id) > 1'))
      .pluck(Arel.sql("students.id, CONCAT(students.first_name, ' ', students.last_name) AS full_name, COUNT(DISTINCT enrollments.course_id) AS class_count"))
  end

  def na_students
    @na_students = Student
      .joins(:enrollments)
      .where(enrollments: { grade: 'N/A' })
      .distinct
  end

  def per_class_statistics
    valid_for_stats = ['A', 'B', 'C', 'D', 'F', 'Q', 'W']
    numeric_valid = ['A', 'B', 'C', 'D', 'F']

    @class_statistics = Course.includes(:enrollments).map do |course|
      course_enrollments = course.enrollments
      filtered = course_enrollments.select { |e| valid_for_stats.include?(e.grade) }
      numeric_grades = filtered
        .select { |e| numeric_valid.include?(e.grade) }
        .map { |e| Enrollment.grade_to_numeric(e.grade) }
        .compact

      total = filtered.size.nonzero? || 1

      {
        course_id: course.id,
        course_name: "#{course.name}#{course.number}-#{course.section} (#{course.semester} #{course.year})",
        student_count: course_enrollments.size,
        average_grade: numeric_grades.any? ? (numeric_grades.sum / numeric_grades.size.to_f).round(2) : nil,
        highest_grade: numeric_grades.max,
        f_rate: (filtered.count { |e| e.grade == 'F' } / total.to_f * 100).round(2),
        q_rate: (filtered.count { |e| e.grade == 'Q' } / total.to_f * 100).round(2),
        w_rate: (filtered.count { |e| e.grade == 'W' } / total.to_f * 100).round(2),
        na_count: course_enrollments.count { |e| e.grade == 'N/A' }
      }
    end
  end
end
