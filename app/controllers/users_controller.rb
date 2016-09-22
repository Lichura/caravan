class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
    @sucursales = @user.user_sucursals.build(:user_id => @user.id)
    @provincias = Provincia.all
    @afip = User.search_afip(params[:search_afip])
    respond_to do |format|
     format.html
     format.js {render "buscar_afip"}
    end
  end

  def new_pedido
    @user = User.new
    @sucursales = @user.user_sucursals.build(:user_id => @user.id)
    @provincias = Provincia.all
    @afip = User.search_afip(params[:search_afip])
    respond_to do |format|
     format.html
    #con esto logro que apenas llamo a new_pedido como no existe la variable afip me carga el
    #modal para un nuevo usuario, luego al realizar una llamada ajax para buscar el numero de afip
    #si me carga el partial de buscar_afip
    if @afip
     format.js {render "buscar_afip"}
    else
     format.js
    end
    end
  end
  def index
    @user = policy_scope(User).paginate(:page => params[:page], :per_page => 10)
    authorize current_user
    #@user = User.paginate(:page => params[:page], :per_page => 10)
    #authorize @user, :mostrar_usuarios?
      if params[:search]
        @user = policy_scope(User).search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @user = policy_scope(User).all.paginate(:page => params[:page], :per_page => 10)
      end
  end
  def show
  end
  def edit
    @profiles = Profile.all
    @provincias = Provincia.all
  end

def buscar
    @user = User
    if params[:search]
      @user = User.search(params[:search])
    else
      @user = User.all
    end
end

def buscar_afip
  @provincias = Provincia.all
  @afip = User.search_afip(params[:search_afip])
  @user = params[:user]
    respond_to do |format|
     format.js {render  "buscar_afip"}
    end
end


def edit_multiple
    @profiles = Profile.all
    @user = User.all
    if params[:search]
      @user = User.search(params[:search])
    else
      @user = User.all
    end
end
def update_multiple
  @user = User.update(params[:users].keys, params[:users].values)
  @user.reject! { |u| u.errors.empty? }
  if @user.empty?
    redirect_to edit_multiple_users_url
  else
    redirect_to edit_multiple_users_url
  end
end

def edit_multiple_condiciones
    @condiciones = CondicionPago.all.collect {|p| [ p.nombre, p.id ] }
    @user = User.all
    if params[:search]
      @user = User.search(params[:search])
    else
      @user = User.all
    end
end

def update_multiple_condiciones
  @user = User.update(params[:users].keys, params[:users].values)
  @user.reject! { |u| u.errors.empty? }
  if @user.empty?
    redirect_to edit_multiple_condiciones_users_url
  else
    render "index"
  end
end






  def create
  	@user = User.new(user_params)
    @user.condicion_id = 1
    if current_user.present?
      if current_user.profile_id == 1
        @user.profile_id = 2
      else
        @user.profile_id = 3
      end
    end
    if @user.password.blank?
      randomstring = SecureRandom.hex(5)
      @user.password = randomstring
      @user.password_confirmation = randomstring
    end
  	if @user.save
      @distribuidor = current_user.relacions.build(:user_id => @user.id, :cliente_id => @user.id )
      @distribuidor.save
      if @user.profile_id == 2
        UserMailer.envio_de_password(@user, @user.password).deliver_later
      end
  		  session[:return_to] ||= request.referer
        redirect_to session.delete(:return_to), :notice => "Se creo el cliente #{@user.razonSocial}"

    else
  		render "new"
  	end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Usuario was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to edit_multiple_users_url, notice: 'El usuario fue eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  	private
    def relacions_params
      params.require(:user).permit(:id, current_user.id)
    end
    def set_multiple_ids
      params[:user_ids]
    end

    def set_user
      @user = User.find(params[:id])
    end
		def user_params
			params.require(:user).permit(:email, :localidad_id, :cuit, :razonSocial, :codigoPostal, :direccion, :cuig, :renspa, :telefono, :pais_id, :encargado, :celular, :numeroCv, :profile_id, :razonSocial, :direccion, :provincia_id, :user_sucursals_attributes => [:id, :_destroy, :nombre, :encargado, :direccion, :telefono])
		end

end
