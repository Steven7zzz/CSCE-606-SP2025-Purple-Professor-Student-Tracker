class StudentRostersController < ApplicationController
  before_action :set_student_roster, only: %i[ show edit update destroy ]

  def index
    @rosters = StudentRoster.distinct.pluck(:roster_name) # Get unique rosters
  end

  def show
    @students = StudentRoster.where(roster_name: params[:id]) # Load students in selected roster
  end

  def import
    if params[:file].present?
      StudentRoster.import(params[:file])
      flash[:notice] = "CSV imported successfully!"
    else
      flash[:alert] = "Please upload a valid CSV file."
    end
    redirect_to student_rosters_path
  end

  # GET /student_rosters/new
  def new
    @student_roster = StudentRoster.new
  end

  # GET /student_rosters/1/edit
  def edit
  end

  # POST /student_rosters or /student_rosters.json
  def create
    @student_roster = StudentRoster.new(student_roster_params)

    respond_to do |format|
      if @student_roster.save
        format.html { redirect_to @student_roster, notice: "Student roster was successfully created." }
        format.json { render :show, status: :created, location: @student_roster }
      end
    end
  end

  # PATCH/PUT /student_rosters/1 or /student_rosters/1.json
  def update
    respond_to do |format|
      if @student_roster.update(student_roster_params)
        format.html { redirect_to @student_roster, notice: "Student roster was successfully updated." }
        format.json { render :show, status: :ok, location: @student_roster }
      end
    end
  end

  # DELETE /student_rosters/1 or /student_rosters/1.json
  def destroy
    @student_roster.destroy!

    respond_to do |format|
      format.html { redirect_to student_rosters_path, status: :see_other, notice: "Student roster was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_roster
      @student_roster = StudentRoster.find_by(roster_name: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_roster_params
      params.expect(student_roster: [ :name, :uin, :major, :class_level, :email, :final ])
    end
end
