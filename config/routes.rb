Rails.application.routes.draw do
  post '/callback', to: 'application#callback'
end
