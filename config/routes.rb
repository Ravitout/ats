Rails.application.routes.draw do
resources :users
resources :candidates
root "candidates#index"
end
