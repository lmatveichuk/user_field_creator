class CreateCustomFields < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.string :field_type
      t.jsonb :options, default: {}

      t.timestamps
    end
  end
end
