Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  
  resources :users, :posts

  get 'comments/new'
  get 'comments/edit'
  get 'comments/create'
  get 'comments/update'
  get 'comments/destroy'
end
