Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :custom_fields, only: [:create]
      resources :custom_field_assignments, only: [:create]
      resources :users, only: [:update]
    end
  end
end
