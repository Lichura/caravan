class PasswordResetsController < ApplicationController

  skip_before_filter :require_login
  def new
  end
  def create
  	if user = User.find_by_email(params[:email])
      if not user.profile_id == 3 
  	   user.send_password_reset if user
  	   redirect_to root_url, :notice => "Se envio un mail con las indicaciones para recuperar su contraseña"
      else
        redirect_to root_url, :notice => "Su usuario no tiene permisos para ingresar al sistema. Pongase en contacto con el administrador."
      end
    else
        redirect_to root_url, :notice => "El usuario no existe. Pongase en contacto con el administrador."
      end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => "Ha expirado su sesion."
  	elsif @user.update_attributes(user_params)
  		redirect_to root_url, :notice => "Se reseteo su contraseña con exito!"
  	else
  		render :edit
  	end
  end

  private

  def user_params
    params.require(:user).permit(:id, :password, :password_confirmation)
  end
end
