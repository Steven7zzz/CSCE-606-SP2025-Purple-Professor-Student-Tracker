class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token[0, 20] # Generate a random password

    if @user.save
      redirect_to users_path, notice: "User added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id]) 
    if user == current_user
      redirect_to users_path, alert: "You can't delete yourself!"
    else
      user.destroy
      redirect_to users_path, notice: "User removed successfully."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
