require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe '.grade_to_numeric' do
    it 'returns correct numeric value for each grade' do
      expect(Enrollment.grade_to_numeric('A')).to eq(4.0)
      expect(Enrollment.grade_to_numeric('B')).to eq(3.0)
      expect(Enrollment.grade_to_numeric('C')).to eq(2.0)
      expect(Enrollment.grade_to_numeric('D')).to eq(1.0)
      expect(Enrollment.grade_to_numeric('F')).to eq(0.0)
    end

    it 'returns nil for non-GPA grades' do
      expect(Enrollment.grade_to_numeric('Q')).to be_nil
      expect(Enrollment.grade_to_numeric('W')).to be_nil
      expect(Enrollment.grade_to_numeric(nil)).to be_nil
    end
  end
end
