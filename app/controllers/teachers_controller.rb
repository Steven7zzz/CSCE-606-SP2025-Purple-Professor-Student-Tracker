require 'csv'
class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all  
  end

  
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to teachers_path, notice: "Teacher added successfully!"
    else
      flash[:alert] = @teacher.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity 
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :uin, :department, :course_and_semester, :description, :email)
  end
end

