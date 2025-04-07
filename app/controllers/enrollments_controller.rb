class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @enrollment, notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enrollment }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy!

    respond_to do |format|
      format.html { redirect_to enrollments_path, status: :see_other, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.expect(enrollment: [ :course_id, :student_id, :grade ])
    end

   
    def grade_to_numeric
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
