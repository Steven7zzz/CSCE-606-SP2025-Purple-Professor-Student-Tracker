class PeerTeacher < ApplicationRecord
    has_many :pt_enrollments, dependent: :destroy
end