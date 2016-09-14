Rails.application.routes.draw do
  
  resources :condicion_pagos
  resources :transportista
  resources :monedas
  resources :medidas
  resources :profiles
  resources :ciudades
  resources :provincias
  resources :paises
  resources :producto_historicos
  resources :productos
  resources :familia
  resources :mensajes

  get 'menu' => "menu#index", :as => "menu"



  
  get 'provincias/buscar'
  #get 'users/new'

  get "distribuidores" => "menu#distribuidores", :as => "distribuidores"
  root :to => "index#index"
  #resources :users do
    resource :user_sucursals
  #  collection do
  #    get 'buscar_afip', to: "users#buscar_afip"
  #    get :edit_multiple
  #    put :update_multiple
  #    get :edit_multiple_condiciones
  #    put :update_multiple_condiciones
  #    get :buscar
  #  end
  #end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
    }

  resources :detalles
  resources :pedidos do
    collection do
      get 'get_precios', to: "pedidos#get_precios"
      get 'get_cliente', to: "pedidos#get_cliente"
    end 
  end

  resources :relacions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


