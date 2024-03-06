FactoryBot.define do
  factory :custom_field_value do
    association :user
    association :custom_field, factory: :text_custom_field
  end
end
