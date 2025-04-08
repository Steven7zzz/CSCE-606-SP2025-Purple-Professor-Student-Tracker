require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:course) do
    Course.create!(name: 'CSCE', number: '606', section: '500', semester: 'Spring', year: '2025')
  end

  let!(:course2) do
    Course.create!(name: 'CSCE', number: '607', section: '501', semester: 'Spring', year: '2025')
  end

  let!(:student1) { Student.create!(first_name: 'John', last_name: 'Doe', uin: '123', major: 'CS', email: 'john@a.com') }
  let!(:student2) { Student.create!(first_name: 'Jane', last_name: 'Smith', uin: '124', major: 'CS', email: 'jane@a.com') }
  let!(:student3) { Student.create!(first_name: 'Max', last_name: 'Payne', uin: '125', major: 'CS', email: 'max@a.com') }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)

    Enrollment.create!(student: student1, course: course, grade: 'A')
    Enrollment.create!(student: student2, course: course, grade: 'F')
    Enrollment.create!(student: student2, course: course2, grade: 'Q') # different course
    Enrollment.create!(student: student3, course: course, grade: 'W')
  end

  describe 'GET #index' do
    it 'assigns total student count, average and highest grade, and duplicate count' do
      get :index

      expect(assigns(:total_students)).to eq(3)
      expect(assigns(:average_grade)).to be_within(0.01).of((4.0 + 0.0) / 2) # A and F only
      expect(assigns(:highest_grade)).to eq(4.0)
      expect(assigns(:duplicate_count)).to eq(1) # student2 is in 2 distinct courses
    end
  end

  describe 'GET #duplicate_students' do
    it 'assigns students enrolled in more than one distinct course' do
      get :duplicate_students

      results = assigns(:duplicate_students)

      expect(results).not_to be_empty
      expect(results.first[0]).to eq(student2.id)
      expect(results.first[1]).to include(student2.first_name)
      expect(results.first[2]).to eq(2) # 2 distinct enrollments
    end
  end

  describe 'GET #per_class_statistics' do
    it 'assigns statistics per class including F/Q/W rates' do
      get :per_class_statistics

      stats = assigns(:class_statistics).find { |s| s[:course_name].include?("CSCE606") }

      expect(stats[:student_count]).to eq(3) # A, F, W
      expect(stats[:average_grade]).to be_within(0.01).of(2.0) # (4 + 0) / 2
      expect(stats[:highest_grade]).to eq(4.0)
      expect(stats[:f_rate]).to eq(33.33)
      expect(stats[:q_rate]).to eq(0.0)
      expect(stats[:w_rate]).to eq(33.33)
    end
  end
end
