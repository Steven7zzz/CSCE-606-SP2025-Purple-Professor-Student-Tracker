class StatisticsController < ApplicationController
    def index
      @total_students = Student.count
  
      @average_grade = Enrollment.select(Arel.sql('AVG(CAST(grade AS FLOAT))')).pluck(Arel.sql('AVG(CAST(grade AS FLOAT))')).first
  
      @highest_grade = Enrollment.maximum(Arel.sql('CAST(grade AS FLOAT)'))
  
      #@students_per_grade = Student.group(:grade).count
    end
  end
  