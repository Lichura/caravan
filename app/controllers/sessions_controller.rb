class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      #puts "#{current_user.name}"
  		#session[:user_id] = user.id
  		flash.now.alert = "logged in!"
  		redirect_to root_url
  	else
  		flash.now.alert = "Usuario o contraseña incorrecta"
  		render "new"
  	end
  end

  def destroy
  	#session[:auth_token] = nil
    cookies.delete(:auth_token)
  	redirect_to root_url, :notice => "Logged out!"
  end
end
