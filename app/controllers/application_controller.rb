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


    #se envia el tipo de articulo (producto/insumo), 
  #el tipo de stock(fisico/reservado/pedido), el id del articulo
  #la cantidad a modificar y el signo (suma/resta)
  def modificar_stock_articulo(tipo, tipo_stock, id, cantidad, signo)
    case tipo
    when "producto"
        articulo = Producto.find(id)
        stock = "producto_#{tipo_stock}"
    when "insumo"
        articulo = Insumo.find(id)
        stock = "articulo_#{tipo_stock}"
    end
    puts ("#{articulo}#{stock}")
    case signo
    when "suma"
      articulo.stock += cantidad
    when "resta"
      articulo.stock -= cantidad
    end
    articulo.save
    puts("Se modifico el stock #{tipo_stock} de #{articulo.nombre} por #{signo} #{cantidad}")
  end


end
