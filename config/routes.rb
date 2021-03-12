Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/contact_us", to: "welcome#contact_us")
  post("/thank_you", to: "welcome#thank_you")
  post '/add_to_cart/:product_id' => 'cart#add_to_cart', :as => 'add_to_cart'

  # Session Routes
  resource :session, only: [:new, :create]
  get 'logout', to: 'sessions#destroy' 

   post '/products/:id/edit', to: 'products#edit', as: :edit_product

  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :users, only: [:new, :create]

 

end