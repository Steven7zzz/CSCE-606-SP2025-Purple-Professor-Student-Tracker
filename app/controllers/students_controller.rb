class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    if student_params[:uin].length != 9
      raise ArgumentError, "UIN must be exactly 9 characters long."
    else
      @student = Student.new(student_params)
    end

    if @student.save
      redirect_to @student
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def student_params
      params.expect(student: [ :uin, :first_name, :last_name, :major, :email ])
    end
end
