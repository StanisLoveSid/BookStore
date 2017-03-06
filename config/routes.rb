Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :book_attachments
  devise_for :users
  resources :users
  root "books#index"

  resources :categories

  resources :books do
    resources :reviews
  end
  resources :checkouts
  resources :orders
  get "/cart", to: "orders#edit"
  resources :order_items, only: [:create, :update, :destroy]
  get "/order_items/:id", to: "order_items#discount"
  get "/catalog", to: "books#catalog"
  get '/checkouts/address', to: "users#address"
end
