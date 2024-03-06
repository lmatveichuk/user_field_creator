class CustomFieldValue < ApplicationRecord
  belongs_to :user
  belongs_to :custom_field

  validate :value_must_be_a_hash
  validate :validate_value_key_and_format, if: :persisted?
  validate :validate_value_against_field_choices, if: -> { custom_field.field_type.in?(['select', 'multiselect']) }

  private

  def value_must_be_a_hash
    unless value.is_a?(Hash)
      errors.add(:options, "must be an object")
    end
  end

  def validate_value_key_and_format
    unless value.key?("value")
      errors.add(:value, "must have a 'value' key")
      return
    end

    validate_value_data_type(value["value"])
  end

  # Validates data type based on the custom field type
  def validate_value_data_type(data)
    expected_type = case custom_field.field_type
                    when 'text', 'select' then String
                    when 'number' then Numeric
                    when 'checkbox' then 'Boolean'
                    when 'multiselect' then Array
                    end

    unless valid_data_type?(data, expected_type)
      errors.add(:value, "data must be a #{expected_type.to_s} for #{custom_field.field_type} fields")
    end
  end

  # Checks if the data is of the expected type
  def valid_data_type?(data, expected_type)
    return data.is_a?(expected_type) unless expected_type == 'Boolean'
    
    data == true || data == false
  end

  # Validates that the value for select and multiselect fields is one of the provided options
  def validate_value_against_field_choices
    choices = custom_field.options['choices']

    selected_values = value['value']
    selected_values = [selected_values] unless selected_values.is_a?(Array) # Treat single and multiple values uniformly

    unless (selected_values - choices).empty?
      errors.add(:value, "must be included in the provided choices for #{custom_field.field_type} fields")
    end
  end
end
