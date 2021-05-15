Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :following, :followers
  end
end

resources :relationships, only: [:create, :destroy]
  root to: "homes#top"
  get "/home/about" => "homes#about"
  
  resources :books do
    # いいね機能
    resource :favorites, only: [:create, :destroy]
    # コメント機能
    resources :book_comments, only: [:create, :destroy]
  end

end
