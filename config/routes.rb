Rails.application.routes.draw do
  devise_for :users
  
   resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]

  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create, :destroy]
    resources :notices, only: [:new, :create] do
      get 'sent', on: :member
    end
  end

  post 'follow/:id', to: 'relationships#create', as: 'follow'
  delete 'unfollow/:id', to: 'relationships#destroy', as: 'unfollow'

  root to: "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search"

end
