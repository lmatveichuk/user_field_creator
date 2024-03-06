require 'rails_helper'

RSpec.describe Api::V1::CustomFieldsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { custom_field: { name: 'Test Field', field_type: 'text', options: { choices: ['Option 1', 'Option 2'] } } } }

      it 'creates a new custom field' do
        expect {
          post :create, params: valid_params
        }.to change(CustomField, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end

=begin
curl request to check controller via postman

curl --location 'http://localhost:3000/api/v1/custom_fields' \
--header 'Content-Type: application/json' \
--data '{"custom_field": {"name": "Нове поле", "field_type": "select", "options": {"choices": ["Test"] }}}'
=end
