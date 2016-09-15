class UserSucursalController < ApplicationController
  before_action :set_user_sucursal, only: [:show, :edit, :update, :destroy]

  # GET /detalles
  # GET /detalles.json
  def index
    @sucursal = UserSucursal.all
  end

  # GET /detalles/1
  # GET /detalles/1.json
  def show
  end

  # GET /detalles/new
  def new
    @sucursal = UserSucursal.new
  end

  # GET /detalles/1/edit
  def edit
  end

  # POST /detalles
  # POST /detalles.json
  def create
    @sucursal = UserSucursal.new(user_sucursal_params)

    respond_to do |format|
      if @sucursal.save
        format.html { redirect_to @sucursal, notice: 'Detalle was successfully created.' }
        format.json { render :show, status: :created, location: @sucursal }
      else
        format.html { render :new }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalles/1
  # PATCH/PUT /detalles/1.json
  def update
    respond_to do |format|
      if @sucursal.update(user_sucursal_params)
        format.html { redirect_to @detalle, notice: 'Detalle was successfully updated.' }
        format.json { render :show, status: :ok, location: @sucursal }
      else
        format.html { render :edit }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalles/1
  # DELETE /detalles/1.json
  def destroy
    @sucursal.destroy
    respond_to do |format|
      format.html { redirect_to detalles_url, notice: 'Detalle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_sucursal
      @sucursal = UserSucursal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_sucursal_params
      params.require(:user_sucursal).permit(:user_id, :nombre, :direccion, :telefono, :encargado)
    end
end

