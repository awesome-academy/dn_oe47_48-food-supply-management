Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/about"
    get "static_pages/contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "admin", to: "users#index"
    get "admin/buyers", to: "users#show_buyers"

    resources :users, only: %i(new create edit destroy)
    resources :categories
    resources :products, only: %i(show)
  end
end
