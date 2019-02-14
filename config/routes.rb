Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get  "upgrade",   to: 'users/registrations#upgrade'
    post "upgrading", to: 'users/registrations#upgrading'
  end

  namespace :admin do
    resources :products
  end

  resources :products

  root 'products#index'
end
