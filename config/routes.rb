Rails.application.routes.draw do
  root :to => "chat_groups#index"
  resources :chat_groups, only: :index
end
