Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # mount SwaggerUiRails::Engine, at: '/swagger'
  # mount Swagger::Docs::Config, at: '/swagger'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for the SchedulesController
  resources :schedules, only: [:create, :index]

  # Routes for the ClientsController
  resources :clients, only: [:index]

  # Routes for the VehiclesController
  resources :vehicles, only: [:index]

end
