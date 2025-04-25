class Course < ApplicationRecord
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments

    has_many :pt_enrollments, dependent: :destroy
    has_many :peer_teachers, through: :pt_enrollments
  
    def safe_destroy
      ActiveRecord::Base.transaction do
        self.students.distinct.each do |student|
          if student.enrollments.count == 1
            # First delete their only enrollment (which must belong to this course)
            student.enrollments.first.destroy!
            # Then delete the student
            student.destroy!
          end
        end
        self.destroy!
      end
    end
  end
  