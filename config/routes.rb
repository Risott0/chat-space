Rails.application.routes.draw do
  resources :chat_groups, only: :index
end
