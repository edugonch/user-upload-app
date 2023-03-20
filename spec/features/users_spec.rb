require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'POST create' do
    context 'with valid data' do
      let(:valid_csv_file_path) { Rails.root.join('spec', 'fixtures', 'valid_csv.csv') }
      let(:valid_csv_file) { Rack::Test::UploadedFile.new(valid_csv_file_path, 'text/csv') }

      it 'creates users' do
        visit root_path
        attach_file('csv_file', valid_csv_file)
        click_on('Import')

        expect(page).to have_content('CSV file imported successfully')
        expect(User.count).to eq(3)
        expect(User.pluck(:name)).to match_array(['John', 'Jane', 'Joe'])
      end
    end

    context 'with invalid data' do
      let(:invalid_csv_file_path) { Rails.root.join('spec', 'fixtures', 'mix_valid_invalid_csv.csv') }
      let(:invalid_csv_file) { Rack::Test::UploadedFile.new(invalid_csv_file_path, 'text/csv') }

      it 'does not create invalid users' do
        visit root_path
        attach_file('csv_file', invalid_csv_file)
        click_on('Import')

        expect(page).to have_content('CSV file contains errors')
        expect(User.count).to eq(1)
        expect(User.pluck(:name)).to match_array(['John'])
      end
    end

    context 'with empty data' do
      let(:empty_csv_file_path) { Rails.root.join('spec', 'fixtures', 'mix_valid_invalid_csv.csv') }
      let(:empty_csv_file) { Rack::Test::UploadedFile.new(empty_csv_file_path, 'text/csv') }

      it 'returns an error' do
        visit root_path
        attach_file('csv_file', empty_csv_file)
        click_on('Import')

        expect(page).to have_content('CSV file is empty')
        expect(User.count).to eq(0)
      end
    end

    context 'with invalid file format' do
      let(:invalid_file_path) { Rails.root.join('spec', 'fixtures', 'invalid_file.txt') }
      let(:invalid_file) { Rack::Test::UploadedFile.new(invalid_file_path, 'text/plain') }

      it 'returns an error' do
        visit root_path
        attach_file('csv_file', invalid_file)
        click_on('Import')

        expect(page).to have_content('Invalid file format')
        expect(User.count).to eq(0)
      end
    end
  end
end
