require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'POST create' do
    context 'with valid data' do
      let(:valid_csv_file_path) { Rails.root.join('spec', 'fixtures', 'valid_csv.csv') }

      it 'creates users' do
        visit root_path
        within('form') do
          attach_file('csv_file', valid_csv_file_path)
          click_on('Import')
        end

        expect(User.count).to eq(3)
        expect(User.pluck(:name)).to match_array(['John', 'Jane', 'Joe'])

        rows = all('table tbody tr')
        expect(rows.size).to eq(3)
        expect(rows[0]).to have_content('John')
        expect(rows[0]).to have_content('success')
        expect(rows[1]).to have_content('Jane')
        expect(rows[1]).to have_content('success')
        expect(rows[2]).to have_content('Joe')
        expect(rows[2]).to have_content('success')
      end
    end

    context 'with invalid data' do
      let(:invalid_csv_file_path) { Rails.root.join('spec', 'fixtures', 'mix_valid_invalid_csv.csv') }

      it 'does not create invalid users' do
        visit root_path
        within('form') do
          attach_file('csv_file', invalid_csv_file_path)
          click_on('Import')
        end

        expect(User.count).to eq(1)
        expect(User.pluck(:name)).to match_array(['John'])

        rows = all('table tbody tr')
        expect(rows.size).to eq(3)
        expect(rows[0]).to have_content('John')
        expect(rows[0]).to have_content('success')
        expect(rows[1]).to have_content('Jane')
        expect(rows[1]).to have_content('error')
        expect(rows[2]).to have_content('Joe')
        expect(rows[2]).to have_content('error')
      end
    end

    context 'with empty data' do
      let(:empty_csv_file_path) { Rails.root.join('spec', 'fixtures', 'empty_csv.csv') }

      it 'returns an error' do
        visit root_path
        within('form') do
          attach_file('csv_file', empty_csv_file_path)
          click_on('Import')
        end

        expect(page).to have_content('CSV file is empty')
        expect(User.count).to eq(0)

        rows = all('table tbody tr')
        expect(rows.size).to eq(0)
      end
    end

    context 'with Invalid file format' do
      let(:invalid_file_path) { Rails.root.join('spec', 'fixtures', 'invalid_file.txt') }

      it 'returns an error' do
        visit root_path
        within('form') do
          attach_file('csv_file', invalid_file_path)
          click_on('Import')
        end

        expect(page).to have_content('Invalid file format')
        expect(User.count).to eq(0)

        rows = all('table tbody tr')
        expect(rows.size).to eq(0)
      end
    end
  end
end