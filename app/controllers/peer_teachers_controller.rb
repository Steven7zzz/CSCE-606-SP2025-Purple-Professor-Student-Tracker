class PeerTeachersController < ApplicationController
  before_action :set_peer_teacher, only: %i[ show edit update destroy ]

  # GET /peer_teachers or /peer_teachers.json
  def index
    @peer_teachers = PeerTeacher.all
  end

  # GET /peer_teachers/1 or /peer_teachers/1.json
  def show
  end

  # GET /peer_teachers/new
  def new
    @peer_teacher = PeerTeacher.new
  end

  # GET /peer_teachers/1/edit
  def edit
  end

  # POST /peer_teachers or /peer_teachers.json
  def create
    @peer_teacher = PeerTeacher.new(peer_teacher_params)

    respond_to do |format|
      if @peer_teacher.save
        format.html { redirect_to @peer_teacher, notice: "Peer teacher was successfully created." }
        format.json { render :show, status: :created, location: @peer_teacher }
      end
    end
  end

  # PATCH/PUT /peer_teachers/1 or /peer_teachers/1.json
  def update
    respond_to do |format|
      if @peer_teacher.update(peer_teacher_params)
        format.html { redirect_to @peer_teacher, notice: "Peer teacher was successfully updated." }
        format.json { render :show, status: :ok, location: @peer_teacher }
      end
    end
  end

  # DELETE /peer_teachers/1 or /peer_teachers/1.json
  def destroy
    @peer_teacher.destroy!

    respond_to do |format|
      format.html { redirect_to peer_teachers_path, status: :see_other, notice: "Peer teacher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peer_teacher
      @peer_teacher = PeerTeacher.find(params.expect(:id))
    end

    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [ :index ]
    # Only allow a list of trusted parameters through.
    def peer_teacher_params
      params.expect(peer_teacher: [ :first_name, :last_name, :uin, :email ])
    end
end
