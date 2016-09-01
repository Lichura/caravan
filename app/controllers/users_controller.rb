class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
    @sucursales = @user.user_sucursals.build(:user_id => @user.id)

    if params[:search_afip]
      @afip = User.search_afip(params[:search_afip])
    else
      @afip = nil
    end

  end
  def index
    @user = User.all
  end
  def show
  end
  def edit
    @profiles = Profile.all
  end

def buscar
    @user = User
    if params[:search]
      @user = User.search(params[:search])
    else
      @user = User.all
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
    if current_user.profile_id == 1
      @user.profile_id = 2
    else
      @user.profile_id = 3
    end
    if @user.password.blank?
      randomstring = SecureRandom.hex(5)
      @user.password = randomstring
      @user.password_confirmation = randomstring
    end
  	if @user.save
      if @user.profile_id == 2
        UserMailer.envio_de_password(@user, @user.password).deliver_later
      end
  		redirect_to edit_multiple_users_pa, :notice => "Se creo el cliente #{@user.razonSocial}"
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
    def set_multiple_ids
      params[:user_ids]
    end

    def set_user
      @user = User.find(params[:id])
    end
		def user_params
			params.require(:user).permit(:email, :localidad_id, :cuit, :provincia_id, :razonSocial, :codigoPostal, :direccion, :cuig, :renspa, :telefono, :codigoPostal, :pais_id, :encargado, :celular, :numeroCv, :profile_id, :razonSocial, :direccion, :provincia_id, :user_sucursals_attributes => [:id, :_destroy, :nombre])       
		end

end
