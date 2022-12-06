Rails.application.routes.draw do
  devise_for :users
resources :users 
resources :candidates
# resources :job_posts
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
  get 'job_posts', to: 'job_posts#index'
  get 'job_posts/new', to: 'job_posts#new'
  post 'job_posts/new', to: 'job_posts#create'
  get '/job_post/:id', to: 'job_posts#show'
  get '/job_posts/:id/edit', to: 'job_posts#edit', as: :edit_jobpost
  put '/job_posts/:id', to: 'job_posts#update', as: :update_post
  delete '/job_posts/:id', to: 'job_posts#destroy'
  get 'post_approve/:id', to: 'job_posts#approval', as: :post_approved
  get 'post_decline/:id', to: 'job_posts#declined', as: :post_declined
end
