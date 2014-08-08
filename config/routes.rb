Rails.application.routes.draw do

  resources :users, only: [:new, :create, :index] do
    resources :goals, shallow: true
  end

  resource :session, only: [:new, :create, :destroy]
end
