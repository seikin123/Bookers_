Rails.application.routes.draw do
  devise_for :users
  # user関連
  resources :users  do 
    collection do
      get 'search'
    end
  end

  # chat機能
  get 'rooms/show'

  # フォロー機能
resources :relationships, only: [:create, :destroy]
  root to: "homes#top"
  get "/home/about" => "homes#about"
  
  # books関連
  resources :books do
    collection do
      get 'search'
    end
    # いいね機能
    resource :favorites, only: [:create, :destroy]
    # コメント機能
    resources :commenters, only: [:create, :destroy]
  end

end
