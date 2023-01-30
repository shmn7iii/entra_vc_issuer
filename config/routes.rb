Rails.application.routes.draw do
  root 'vid#new'

  resources :vid, only: %i[new create show]
  post '/callback', to: 'application#callback'
end
