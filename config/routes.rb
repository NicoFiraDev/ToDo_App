Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/new'
  get 'tasks/edit'
  get 'tasks/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'welcome#home', as: :authenticated_root
  end
  root 'welcome#home'
  resources :lists do
    resources :tasks do
      get :toggle_status
    end
  end
end
