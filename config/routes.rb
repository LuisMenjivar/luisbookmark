Rails.application.routes.draw do
  devise_for :users
  root to: "welcome#index"
  post :bookmarks, to: 'bookmarks#create_bookmark'
end
