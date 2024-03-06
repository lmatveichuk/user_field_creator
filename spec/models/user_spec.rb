require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:custom_field_values) }
    it { should have_many(:custom_fields).through(:custom_field_values) }
  end

  describe "scopes" do
    describe ".with_custom_fields_and_values" do
      it "includes custom field values and custom fields" do
        user = create(:user)
        custom_field = create(:text_custom_field)
        custom_field_value = FactoryBot.create(:custom_field_value, user: user, custom_field: custom_field)

        users = User.with_custom_fields_and_values

        expect(users).to include(user)
        expect(users.first.custom_field_values).to include(custom_field_value)
        expect(users.first.custom_fields).to include(custom_field)
      end
    end
  end
end
