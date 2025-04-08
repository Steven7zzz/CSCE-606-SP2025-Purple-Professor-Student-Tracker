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

    enrollments = Enrollment.joins(:course)
                            .where(grade: valid_grades)
                            .select(:course_id, :grade)

    numeric_grades_by_course = enrollments.group_by(&:course_id).transform_values do |enrollments|
      enrollments.map { |enrollment| Enrollment.grade_to_numeric(enrollment.grade) }.compact
    end

    @class_statistics = numeric_grades_by_course.map do |course_id, grades|
      {
        course_name: Course.find(course_id).name,
        student_count: grades.size,
        average_grade: grades.sum / grades.size.to_f,
        highest_grade: grades.max
      }
    end
  end
end