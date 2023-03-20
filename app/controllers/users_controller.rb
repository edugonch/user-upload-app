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

    CSV.parse(csv_data, headers: true) do |row|
      user = User.new(name: row['name'], password: row['password'])
      if user.valid?
        user.save
        @results << { name: user.name, password: user.password, status: 'success' }
      else
        @results << { name: row['name'], password: row['password'], status: 'error', errors: user.errors.full_messages }
      end
    end

    if @results.empty?
      flash[:alert] = 'CSV file is empty'
      render :index, status: :unprocessable_entity
    else
      render :index, status: :ok
    end
  end
end
