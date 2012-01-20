GameChecker::Application.routes.draw do
  resources :users
  resource :session
  resources :games

  root :to => 'games#index'
end
