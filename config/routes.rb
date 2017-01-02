Rails.application.routes.draw do
  resources :pagina_principals
  resources :insumos
  resources :pagos
  resources :nota_creditos
  get 'cuenta_corriente/index', :as => 'cuentascorrientes'
  get 'stock_pedidos/new_producto' => 'stock_pedidos#new_producto'
  resources :facturas
  resources :remitos
  resources :numeradors
  resources :stock_pedidos
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

  get 'users/afip_fields' => 'users#afip_fields'
  get 'stock_pedidos/new_producto' => 'stock_pedidos#new_producto', :as => 'new_producto_stock'
  get 'cheques' => 'cheques#index', :as => "cheques"
  get 'menu' => "menu#index", :as => "menu"
  post 'remitos/show_all' => "remitos#show_all", :as => "mostrar_remitos"
  get 'users/new_pedido' => "users#new_pedido", :as=> "nuevo_usuario_pedido"
  get 'password_resets/new'
  get 'password_resets/show'
  get 'password_resets/edit'
  get 'sessions/new'
  post 'users/new'
  get 'provincias/buscar'
  #get 'users/new'
  get "log_out" => "sessions#destroy", :as=> "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "distribuidores" => "menu#distribuidores", :as => "distribuidores"
  get "dashboard" => "menu#dashboard", :as => "dashboard"
  root :to => "index#index"
  resources :users do
    resource :user_sucursals
    collection do
      get 'buscar_afip', to: "users#buscar_afip"
      get :edit_multiple
      put :update_multiple
      get :edit_multiple_condiciones
      put :update_multiple_condiciones
      get :buscar
    end
  end

  resources :cheques do
    collection do
      get :update_multiple
    end
  end

  resources :detalles
  resources :pedidos do
    collection do
      get 'get_precios', to: "pedidos#get_precios"
      get 'get_cliente', to: "pedidos#get_cliente"
      get 'rango_pedido', to: "pedidos#rango_pedido"
    end 
  end



  post 'facturas/new' => "facturas#new"
  get 'nueva_factura' => "facturas#nueva_factura", :as => "nueva_factura"
  resources :facturas do
    collection do
      post :remitos
    end
  end

  resources :relacions
  resources :password_resets
  resources :sessions


  resources :charts, only: [] do
  collection do
    get 'evolucion_precios'
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


