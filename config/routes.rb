Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/about"
    get "static_pages/contact"
    get "/search", to: "products#search"
    devise_for :users
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
    end
    resources :cart_sessions, only: %i(index create) do
      collection do
        post "change"
        delete "remove"
      end
    end
    
    resources :cart_sessions
    resources :static_pages

    namespace :admin do
      root "admins#index"
      resources :users, only: :index
      resources :orders, only: %i(index update)
      resources :products, only: :index
    end

    resources :users, except: %i(index destroy)
    resources :categories do
      resources :products, only: :show
    end
  end
end
