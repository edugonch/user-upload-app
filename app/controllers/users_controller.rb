require 'csv'

class UsersController < ApplicationController
  def index; end

  def create
    @results = []

    if params[:csv_file].nil?
      flash[:alert] = 'Please select a file to upload'
      render :index, status: :unprocessable_entity
      return
    end

    unless params[:csv_file].content_type == 'text/csv'
      flash[:alert] = 'Invalid file format'
      render :index, status: :unprocessable_entity
      return
    end

    csv_data = params[:csv_file].read
    @results = User.create_from_csv(csv_data)

    if @results.empty?
      flash[:alert] = 'CSV file is empty'
      render :index, status: :unprocessable_entity
    else
      render :index, status: :ok
    end
  end
end
