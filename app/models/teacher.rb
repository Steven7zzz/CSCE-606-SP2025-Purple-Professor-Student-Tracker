class Teacher < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :uin, presence: true
  validates :department, presence: true
  validates :course_and_semester, presence: true
  validates :description, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
