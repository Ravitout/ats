Rails.application.routes.draw do
resources :users do
	get "sign_in"
end
resources :candidates
root "candidates#index"
end
