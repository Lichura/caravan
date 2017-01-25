class SessionsController < ApplicationController
    skip_before_filter :require_login
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    #si el usuario es un cliente, lo redirijo a la pagina principal y no lo dejo loguearse
    if  !user.present? || user.profile_id == 3
        flash.now.alert = "Su usuario no cuenta con permisos para iniciar sesion"
        redirect_to root_url
    else
    	if user && user.authenticate(params[:password])
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        #puts "#{current_user.name}"
    		#session[:user_id] = user.id
    		flash.now.alert = "Bienvenido!"
        if user.profile_id == 1
    		  redirect_to menu_url
        else
          redirect_to distribuidores_url
        end
    	else
    		flash.now.alert = "Usuario o contraseña incorrecta"
    		render "new"
    	end
    end
  end

  def destroy
  	#session[:auth_token] = nil
    cookies.delete(:auth_token)
  	redirect_to root_url, :notice => "Logged out!"
  end
end
