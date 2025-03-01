class PtEnrollment < ApplicationRecord
  belongs_to :course
  belongs_to :peer_teacher
end
