Rails.application.routes.draw do
  root "ebooks#index"

  resources :ebooks do
    member do
      get :download
      get :read
    end

    collection do
      get :search
    end
  end
end