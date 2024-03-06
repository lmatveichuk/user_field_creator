require 'rails_helper'

RSpec.describe CustomFieldValue, type: :model do
  let(:user) { create(:user) }
  let(:custom_field) { create(:text_custom_field) }

  describe 'validations' do
    context 'when value is not a hash' do
      it 'adds an error to options' do
        custom_field_value = build(:custom_field_value, user: user, custom_field: custom_field, value: 'Test')

        expect(custom_field_value).not_to be_valid
        expect(custom_field_value.errors[:options]).to include("must be an object")
      end
    end
  end
end
