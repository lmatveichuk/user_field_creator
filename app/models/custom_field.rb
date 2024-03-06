class CustomField < ApplicationRecord
  # Valid field types that can be used
  VALID_FIELD_TYPES = ['text', 'select', 'multiselect', 'number', 'checkbox'].freeze

  # Validation to ensure that the field type value belongs to valid types
  validates :field_type, inclusion: { in: VALID_FIELD_TYPES, message: "%{value} is not a valid field type" }

  # Validation to ensure the presence of options for select and multiselect fields
  validate :validate_options_presence_for_select_fields
  validate :options_must_be_a_hash


  has_many :custom_field_values
  has_many :users, through: :custom_field_values

  private

  # Validation method to check the presence of options for select and multiselect fields
  def validate_options_presence_for_select_fields
    return unless ['select', 'multiselect'].include?(field_type)

    choices = options['choices']

    if choices.blank? || !choices.is_a?(Array) || choices.empty?
      errors.add(:options, "must include at least one choice for select or multiselect fields")
    end
  rescue JSON::ParserError
    errors.add(:options, "is not a valid JSON format")
  end

  def options_must_be_a_hash
    unless options.is_a?(Hash)
      errors.add(:options, "must be an object")
    end
  end
end
