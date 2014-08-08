Rails.application.routes.draw do
  shallow do
    resources :users, only: [:new, :create, :index] do
      resources :goals
    end
  end

  post :comment, to: "comments#create"
  delete :comment, to: "comments#destroy"

  resource :session, only: [:new, :create, :destroy]
end
