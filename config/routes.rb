GameChecker::Application.routes.draw do
  resources :users
  resource :session
  resources :games do
    member do
      post 'check'
      post 'play'
    end
  end

  root :to => 'games#index'
end
