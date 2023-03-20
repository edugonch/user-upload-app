require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST /create' do
    context 'with valid data' do
      let(:csv_data) { "name,password\nJohn,Aqpfk1swods\nJane,QPFJWz1343439\nJoe,PFSHH78KSMa" }

      it 'creates users' do
        post :create, params: { csv_data: csv_data }
        expect(response).to have_http_status(:ok)

        expect(User.count).to eq(3)
        expect(User.pluck(:name)).to match_array(['John', 'Jane', 'Joe'])
      end
    end

    context 'with invalid data' do
      let(:csv_data) { "name,password\nJohn,Aqpfk1swods\nJane,invalid_password\nJoe,PFSHH78KSMa" }

      it 'does not create invalid users' do
        post :create, params: { csv_data: csv_data }
        expect(response).to have_http_status(:ok)

        expect(User.count).to eq(1)
        expect(User.pluck(:name)).to match_array(['John'])
      end
    end

    context 'with empty data' do
      let(:csv_data) { '' }

      it 'returns an error' do
        post :create, params: { csv_data: csv_data }
        expect(response).to have_http_status(:unprocessable_entity)

        expect(User.count).to eq(0)
      end
    end

    context 'with invalid file format' do
      let(:csv_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'invalid_file.txt'), 'text/plain') }

      it 'returns an error' do
        post :create, params: { csv_file: csv_file }
        expect(response).to have_http_status(:unprocessable_entity)

        expect(User.count).to eq(0)
      end
    end

    context 'with invalid CSV format' do
      let(:csv_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'invalid_csv.csv'), 'text/csv') }

      it 'returns an error' do
        post :create, params: { csv_file: csv_file }
        expect(response).to have_http_status(:unprocessable_entity)

        expect(User.count).to eq(0)
      end
    end
  end
end
