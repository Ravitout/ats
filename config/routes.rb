Rails.application.routes.draw do
resources :users 
resources :candidates
root "sessions#new"
  # get 'sessions/new'
  get    'sign_in', to: 'sessions#new'
  post   'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' 
  # get 'approval', to: 'users#approval'
end
