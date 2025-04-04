require "#{Rails.root}/app/services/csv_parser"

class RostersController < ApplicationController
  def index
    @rosters = Course.all
  end

  def import
    if params[:file].present?
      CsvParser.import(params[:file])
      flash[:notice] = "CSV imported successfully!"
    else
      flash[:alert] = "Please upload a valid CSV file."
    end
    redirect_to courses_path
  end

  def show
    sort_column_options = %w[first_name last_name uin major email]
    order_options = %w[asc desc]
    sort = sort_column_options.include?(params[:sort]) ? params[:sort] : (session[:sort] || "first_name")
    order = order_options.include?(params[:order]) ? params[:order] : (session[:order] || "asc")
    session[:sort] = sort
    session[:order] = order
    @sort = sort
    @order = order

    @course = Course.find(params[:id])
    @course_students = @course.students.order("#{sort} #{order}")
  end
end
