Rails.application.routes.draw do
  mount API::Base, at: "/test"
  get '/auth/:provider/callback', to: 'sessions#create'
end
