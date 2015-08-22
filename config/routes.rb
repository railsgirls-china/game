Rails.application.routes.draw do

  resources :gifts do
    get :luck, on: :member
    get :reset, on: :member
  end
  resources :users

end
