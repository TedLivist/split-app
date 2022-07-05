Rails.application.routes.draw do
  devise_for :users
  resources :expenses, only: [:new, :create]
  # get 'splits/amount', to: "splits#amount"
  # post 'splits', to: "splits#create"

  resources :debts, only: [:new, :create, :index, :show, :edit, :update]
  # get 'debts#index', to: "debts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static#dashboard"
  get 'people/:id', to: 'static#person'
end
