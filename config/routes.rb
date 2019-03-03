Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get  "upgrade",   to: 'users/registrations#upgrade'
    post "upgrading", to: 'users/registrations#upgrading'
  end

  namespace :admin do
    resources :products, except: [:show, :destroy]
  end

  resources :products, only: [:index, :show]

  root 'products#index'
end
