class PtEnrollment < ApplicationRecord
  belongs_to :course
  belongs_to :peer_teacher

  validates :peer_teacher_id,
            uniqueness: {
              scope: :course_id,
              message: "has already been assigned to this course"
            }
end
