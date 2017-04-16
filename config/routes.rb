Rails.application.routes.draw do
  devise_for :users
  root :to => "chat_groups#index"
  resources :chat_groups, only: :index
end
