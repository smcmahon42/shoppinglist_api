ListApi::Application.routes.draw do

  root "home#index"

  resources :authorize do
    collection do 
      get 'login'
    end
  end
  
  resources :items

  resources :users do
    resources :groups
  end

  resources :groups do
    resources :users
    resources :shoppinglists
  end

  resources :shoppinglists do
    resources :items
  end

  match ':controller(/:action(/:id))', :via => [:get, :post, :put]

end
