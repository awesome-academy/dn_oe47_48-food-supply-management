Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home" 
    get "static_pages/home"
    get "static_pages/about"
    get "static_pages/contact"
    resources :categories
    resources :products, only: %i(show)
  end
end
