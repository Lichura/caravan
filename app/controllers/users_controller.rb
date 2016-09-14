class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :admin_required
    before_filter :distribuidor_required
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
  def index
    @user = User.all
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
  		redirect_to edit_multiple_users_path, :notice => "Se creo el cliente #{@user.razonSocial}"
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
