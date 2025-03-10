class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index] #unlogged user can visit root path
  def index
  end
end
