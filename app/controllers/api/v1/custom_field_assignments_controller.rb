module Api
  module V1
    class CustomFieldAssignmentsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        user_ids = params[:user_ids] 
        custom_field = CustomField.find(params[:custom_field_id])

        users = User.where(id: user_ids)
        users.each do |user|
          
          user.custom_fields << custom_field unless user.custom_fields.include?(custom_field)
        end

        if users.any?
          render json: { message: "Custom field successfully assigned to users" }, status: :ok
        else
          render json: { message: "No users found or custom field not assigned" }, status: :not_found
        end
      end
    end
  end
end
  