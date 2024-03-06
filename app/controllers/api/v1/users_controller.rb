module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user, only: [:update]

      def update
        unless @user
          render json: { error: 'User not found' }, status: :not_found
          return
        end

        custom_fields_params.each do |custom_field_id, value|
          custom_field = CustomField.find_by(id: custom_field_id)
          unless custom_field
            render json: { error: "Custom field with id #{custom_field_id} not found" }, status: :unprocessable_entity
            return
          end

          custom_field_value = @user.custom_field_values.find_by(custom_field_id: custom_field_id)
          unless custom_field_value
            render json: { error: "Custom field value for custom field with id #{custom_field_id} not found" }, status: :unprocessable_entity
            return
          end

          custom_field_value.update(value: value)
        end

        render json: @user.custom_field_values
      end

      private

      def set_user
        @user = User.find_by(id: params[:id])
      end

      def custom_fields_params
        params.require(:custom_fields)
      end
      
    end
  end
end


=begin
example of request

curl -X PUT \
  http://localhost:3000/api/v1/users/1 \
  -H 'Content-Type: application/json' \
  -d '{
    "custom_fields": {
        "1": {"value": "Test"}
    }
}'

=end
