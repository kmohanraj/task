Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "finances#index"

  resources :finances, only: [:index, :create]

end