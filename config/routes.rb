Rails.application.routes.draw do
  get 'lists/index'
  get 'lists/show'
  get 'lists/new'
  get 'lists/create'
  get 'lists/edit'
  get 'lists/update'
  get 'lists/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
