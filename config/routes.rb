Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'lists#index', as: :authenticated_root
  end

  root 'lists#index'

  resources :lists do
    resources :tasks do
      get :toggle_status
    end
  end
end
