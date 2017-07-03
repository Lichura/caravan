class InsumosController < ApplicationController
  before_action :set_insumo, only: [:show, :edit, :copy, :update, :destroy]

  # GET /insumos
  # GET /insumos.json
  def index
    @insumos = Insumo.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /insumos/1
  # GET /insumos/1.json
  def show
  end

  # GET /insumos/new
  def new
    @insumo = Insumo.new
  end

  def copy
    @insumo = Insumo.find(params[:id]).dup
  end

  # GET /insumos/1/edit
  def edit
  end

  # POST /insumos
  # POST /insumos.json
  def create
    @insumo = Insumo.new(insumo_params)

    respond_to do |format|
      if @insumo.save
        format.html { redirect_to @insumo, notice: 'Se creo el insumo correctamente' }
        format.json { render :show, status: :created, location: @insumo }
      else
        format.html { render :new }
        format.json { render json: @insumo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insumos/1
  # PATCH/PUT /insumos/1.json
  def update
    respond_to do |format|
      if @insumo.update(insumo_params)
        format.html { redirect_to @insumo, notice: 'Se actualizo el insumo correctamente' }
        format.json { render :show, status: :ok, location: @insumo }
      else
        format.html { render :edit }
        format.json { render json: @insumo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insumos/1
  # DELETE /insumos/1.json
  def destroy
    if @insumo.chequear_uso_antes_de_eliminar
    @insumo.destroy
    respond_to do |format|
      format.html { redirect_to insumos_url, notice: 'Se elimino el insumo correctamente.' }
      format.json { head :no_content }
    end
    else
    respond_to do |format|
      format.html { redirect_to insumos_url, notice: 'El insumo ha sido utilizado en un pedido y no es posible eliminarlo.' }
      format.json { head :no_content }
    end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insumo
      @insumo = Insumo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insumo_params
      params.require(:insumo).permit(:nombre, :descripcion, :precio, :color, :unidad_medida, :alerta, :stock_fisico, :stock_reservado, :stock_disponible, :stock_pedido, :imagen)
    end
end
