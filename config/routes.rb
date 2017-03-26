Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/edit'

  get 'comments/create'

  get 'comments/update'

  get 'comments/destroy'

  devise_for :users
  
  resources :users, :posts
end
