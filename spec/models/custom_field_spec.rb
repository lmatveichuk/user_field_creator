require 'rails_helper'

RSpec.describe CustomField, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    let(:custom_field) { create(:text_custom_field) }
    let(:custom_field_select) { create(:select_custom_field, options: { 'choices' => ['Option 1', 'Option 2'] }) }
    let(:valid_value) { { 'value' => 'Some text' } }
    let(:invalid_value) { [] }

    context 'when value is not a hash' do
      it 'is not valid' do
        custom_field_value = build(:custom_field_value, custom_field: custom_field, user: user, value: invalid_value)
        expect(custom_field_value).not_to be_valid
        expect(custom_field_value.errors[:options]).to include("must be an object")
      end
    end

    context 'when field_type is "select" and value is not in choices' do
      it 'is not valid' do
        invalid_value_for_select = { 'value' => 'Invalid option' }
        custom_field_value = build(:custom_field_value, custom_field: custom_field_select, user: user, value: invalid_value_for_select)
        expect(custom_field_value).not_to be_valid
        expect(custom_field_value.errors[:value]).to include("must be included in the provided choices for select fields")
      end
    end

    context 'when field_type is "select" and value is in choices' do
      it 'is valid' do
        valid_value_for_select = { 'value' => 'Option 1' }
        custom_field_value = build(:custom_field_value, custom_field: custom_field_select, user: user, value: valid_value_for_select)
        expect(custom_field_value).to be_valid
      end
    end
  end

  describe "associations" do
    it { should have_many(:custom_field_values) }
    it { should have_many(:users).through(:custom_field_values) }
  end
end
