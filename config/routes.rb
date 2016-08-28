Rails.application.routes.draw do
  resources :medidas
  resources :profiles
  resources :ciudades
  resources :provincias
  resources :paises
  resources :producto_historicos
  resources :productos
  resources :familia
  resources :mensajes
  get 'password_resets/new'
  get 'password_resets/show'
  get 'password_resets/edit'
  get 'sessions/new'

  #get 'users/new' 
  get "log_out" => "sessions#destroy", :as=> "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  root :to => "index#index"
  resources :users do
    collection do
      get :buscar_afip
      get :edit_multiple
      put :update_multiple
      get :buscar
    end
  end

  resources :detalles
  resources :pedidos do
    collection do
      get 'get_precios', to: "pedidos#get_precios"
    end 
  end


  resources :password_resets
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


