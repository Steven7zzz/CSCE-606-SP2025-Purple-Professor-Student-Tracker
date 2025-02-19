class StudentsController < ApplicationController
  def index
    @students = Student.all

    sorting_column = params[:sort]
    sorting_type = params[:direction]

    @sorting_type = ['asc', 'desc'].include?(sorting_type) ? sorting_type : 'asc'

    valid_columns = ['first_name', 'last_name', 'uin']
    @sorting_column = valid_columns.include?(sorting_column) ? sorting_column : 'first_name'

    @students = Student.order("#{@sorting_column} #{@sorting_type}")
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