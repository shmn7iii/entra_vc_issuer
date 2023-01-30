Rails.application.routes.draw do
  root 'credentials#new'

  resources :credentials, only: %i[new create]
  get '/credentials/result', to: 'credentials#result'
  post '/callback', to: 'application#callback'
end
