Rails.application.routes.draw do
  devise_for :users
  resources :users  do 
    collection do
      get 'search'
    end
  end

resources :relationships, only: [:create, :destroy]
  root to: "homes#top"
  get "/home/about" => "homes#about"
  
  resources :books do
    collection do
      get 'search'
    end
    # いいね機能
    resource :favorites, only: [:create, :destroy]
    # コメント機能
    resources :book_comments, only: [:create, :destroy]
  end

end
