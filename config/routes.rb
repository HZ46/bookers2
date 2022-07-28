Rails.application.routes.draw do
  devise_for :users
  get 'home/about' =>'homes#about', as:'about'
  resources :users
  resources :books
root to: "homes#top"
end
