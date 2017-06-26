class ApplicationController < ActionController::Base
    #protect_from_forgery with: :exception
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    #protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  before_action :require_login


  helper_method :current_user
  add_flash_types :contacto_error, :another_custom_type
  def login_required

   if current_user.blank?
   	redirect_to root_url, :notice => "no esta autorizado!"
   end
  end






private

  def require_login
    unless logged_in?
      flash[:error] = "Es necesario ingresar al sistema para realizar esta accion."
      redirect_to log_in_path # halts request cycle
    end
  end

  def user_not_authorized
    flash[:alert] = "Usted no se encuentra autorizado para realizar esa accion."
    redirect_to(request.referrer || root_path)
  end
  def current_user
  	#@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    @current_user ||= User.where("auth_token =?", cookies[:auth_token]).first if cookies[:auth_token]
  end

  def logged_in?
   current_user != nil
  end




end
