Rails.application.routes.draw do
  resources :tweets
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root "tweets#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
