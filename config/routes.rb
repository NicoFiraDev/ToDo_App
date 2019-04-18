Rails.application.routes.draw do
  root 'welcome#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end
end
