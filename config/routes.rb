Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/about"
    get "static_pages/contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "products#search"
    resources :cart_sessions
    resources :users
    resources :static_pages

    namespace :admin do
      root "admins#index"
      resources :users, only: :index
    end

    resources :users, except: %i(index destroy)
    resources :categories do
      resources :products, only: %i(show)
    end
  end
end
