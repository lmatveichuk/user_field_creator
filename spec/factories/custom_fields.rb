FactoryBot.define do
    # Text field
    factory :text_custom_field, class: 'CustomField' do
      name { "Text field" }
      field_type { "text" }
      options { {} }
    end
  
    # Number field
    factory :number_custom_field, class: 'CustomField' do
      name { "Number field" }
      field_type { "number" }
      options { {} }
    end
  
    # Checkbox
    factory :checkbox_custom_field, class: 'CustomField' do
      name { "Checkbox" }
      field_type { "checkbox" }
      options { {} }
    end
  
    # Select field
    factory :select_custom_field, class: 'CustomField' do
      name { "Select field" }
      field_type { "select" }
      options { { choices: ["Option 1", "Option 2"] }.to_json }
    end
  
    # Multiselect
    factory :multiselect_custom_field, class: 'CustomField' do
      name { "Multiselect" }
      field_type { "multiselect" }
      options { { choices: ["Option A", "Option B"] }.to_json }
    end
  end
  