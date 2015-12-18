Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
    controllers: {omniauth_callbacks: "omniauth_callbacks"}
  scope "(:locale)", locale: /en|vn/ do
    root             "static_pages#home"
    get "home"    => "static_pages#home"
    get "about"   => "static_pages#about"
    get "contact" => "static_pages#contact"

    namespace :admin do
      root "categories#index"
      resources :categories
      resources :words
    end

    devise_for :users, skip: :omniauth_callbacks,
      controllers: {registrations: "registrations"}
    resources :users
    resources :follows
    resources :categories, only: [:index]
    resources :words, only: [:index]
    resources :lessons

    namespace :api do
      namespace :v1 do
        resources :categories, only: [:index, :show]
        resources :words, only: [:index, :show]
      end
    end
  end
end
