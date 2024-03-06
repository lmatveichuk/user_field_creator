module Api
  module V1
    class CustomFieldsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
          @custom_field = CustomField.new(custom_field_params)
          if @custom_field.save
          render json: @custom_field, status: :created
          else
          render json: @custom_field.errors, status: :unprocessable_entity
          end
      end

      private

      def custom_field_params
          params.require(:custom_field).permit(:name, :field_type, options: {})
      end
      
    end
  end
end