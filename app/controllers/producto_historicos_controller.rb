class ProductoHistoricosController < ApplicationController
  before_action :set_producto_historico, only: [:show, :edit, :update, :destroy]
  before_filter :admin_required
  # GET /producto_historicos
  # GET /producto_historicos.json
  def index
    @producto_historicos = ProductoHistorico.all
  end

  # GET /producto_historicos/1
  # GET /producto_historicos/1.json
  def show
  end

  # GET /producto_historicos/new
  def new
    @producto_historico = ProductoHistorico.new
  end

  # GET /producto_historicos/1/edit
  def edit
  end

  # POST /producto_historicos
  # POST /producto_historicos.json
  def create
    @producto_historico = ProductoHistorico.new(producto_historico_params)

    respond_to do |format|
      if @producto_historico.save
        format.html { redirect_to @producto_historico, notice: 'Producto historico was successfully created.' }
        format.json { render :show, status: :created, location: @producto_historico }
      else
        format.html { render :new }
        format.json { render json: @producto_historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producto_historicos/1
  # PATCH/PUT /producto_historicos/1.json
  def update
    respond_to do |format|
      if @producto_historico.update(producto_historico_params)
        format.html { redirect_to @producto_historico, notice: 'Producto historico was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto_historico }
      else
        format.html { render :edit }
        format.json { render json: @producto_historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_historicos/1
  # DELETE /producto_historicos/1.json
  def destroy
    @producto_historico.destroy
    respond_to do |format|
      format.html { redirect_to producto_historicos_url, notice: 'Producto historico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto_historico
      @producto_historico = ProductoHistorico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_historico_params
      params.require(:producto_historico).permit(:producto_id, :precio, :fechaDesde, :fechaHasta)
    end
end
