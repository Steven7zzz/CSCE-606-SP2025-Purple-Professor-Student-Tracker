require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe "validations" do
    subject { Teacher.new(first_name: "John", last_name: "Doe", uin: "12345678", department: "Math", course_and_semester: "MATH 101", description: "Professor", email: "john@example.com") }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:uin) }
    it { should validate_presence_of(:department) }
    it { should validate_presence_of(:course_and_semester) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
