class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student

  def self.grade_to_numeric(grade)
    case grade
    when 'A' then 4.0
    when 'B' then 3.0
    when 'C' then 2.0
    when 'D' then 1.0
    when 'F' then 0.0
    else nil
    end
  end
end
