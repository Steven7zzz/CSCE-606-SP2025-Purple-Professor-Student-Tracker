class PtEnrollmentsController < ApplicationController
  before_action :set_pt_enrollment, only: %i[ show edit update destroy ]

  # GET /pt_enrollments or /pt_enrollments.json
  def index
    @pt_enrollments = PtEnrollment.all
  end

  # GET /pt_enrollments/1 or /pt_enrollments/1.json
  def show
  end

  # GET /pt_enrollments/new
  def new
    @pt_enrollment = PtEnrollment.new
  end

  # GET /pt_enrollments/1/edit
  def edit
  end

  # POST /pt_enrollments or /pt_enrollments.json
  def create
    @pt_enrollment = PtEnrollment.new(pt_enrollment_params)

    respond_to do |format|
      if @pt_enrollment.save
        format.html { redirect_to @pt_enrollment, notice: "Pt enrollment was successfully created." }
        format.json { render :show, status: :created, location: @pt_enrollment }
      end
    end
  end

  # PATCH/PUT /pt_enrollments/1 or /pt_enrollments/1.json
  def update
    respond_to do |format|
      if @pt_enrollment.update(pt_enrollment_params)
        format.html { redirect_to @pt_enrollment, notice: "Pt enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @pt_enrollment }
      end
    end
  end

  # DELETE /pt_enrollments/1 or /pt_enrollments/1.json
  def destroy
    @pt_enrollment.destroy!

    respond_to do |format|
      format.html { redirect_to pt_enrollments_path, status: :see_other, notice: "Pt enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pt_enrollment
      @pt_enrollment = PtEnrollment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def pt_enrollment_params
      params.expect(pt_enrollment: [ :Course_id, :PeerTeacher_id ])
    end
end
