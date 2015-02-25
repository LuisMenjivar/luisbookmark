Rails.application.routes.draw do
  devise_for :users
  root to: "welcome#index"
  post :bookmarks, to: 'bookmarks#create_bookmark_from_mail'
  resources :topics, only: [:index, :show, :edit, :destroy, :update]
end
