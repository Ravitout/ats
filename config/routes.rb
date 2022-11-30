Rails.application.routes.draw do
resources :users 
resources :candidates
root "candidates#dashboard"
  # get 'sessions/new'
  get    'sign_in', to: 'sessions#new'
  post   'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'candidates#dashboard'
  get 'approve/:id', to: 'users#approval', as: :approved
  get 'decline/:id', to: 'users#decline', as: :declined
  get 'probing', to: 'candidates#probing', as: :probing
  post 'probing', to: 'candidates#modify' 
  get 'docs_submission', to: 'candidate_clears#new'
  post 'docs_submission', to: 'candidate_clears#create'
  get 'docs_view', to: 'candidate_clears#index'
end
