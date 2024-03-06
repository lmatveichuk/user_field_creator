class User < ApplicationRecord
  has_many :custom_field_values
  has_many :custom_fields, through: :custom_field_values

  scope :with_custom_fields_and_values, -> {
    includes(custom_field_values: :custom_field)
  }
end
