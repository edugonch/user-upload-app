require 'csv'

class UsersController < ApplicationController
  def index; end

  def create
    @results = []

    if params[:csv_file].nil?
      flash[:alert] = 'Please select a file to upload'
      redirect_to root_path, status: :unprocessable_entity
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
      redirect_to root_path, status: :unprocessable_entity
    else
      flash[:notice] = 'CSV file uploaded successfully'
      redirect_to root_path, status: :ok
    end
  end
end
