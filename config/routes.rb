Rails.application.routes.draw do
  devise_for :users
  root to: "welcome#index"
  resources :topics do 
    resources :bookmarks do 
      resources :likes, only: [:create, :destroy]
    end
  end
  post :bookmarks, to: 'bookmarks#create_bookmark_from_mail'
end