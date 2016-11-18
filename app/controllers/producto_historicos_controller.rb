class ProductoHistoricosController < ApplicationController
  before_action :set_producto_historico, only: [:show, :edit, :update, :destroy]

  # GET /producto_historicos
  # GET /producto_historicos.json
  def index
    @producto_historicos = ProductoHistorico.all
    @insumo_historicos = InsumoHistorico.all
    @detalle_producto = Detalle.all
    authorize @producto_historicos
    @historico = ProductoHistorico.group(:producto_id).count 
    @pedidos = Pedido.all
    @historico = []
    @ventas = []
    @insumo_historico = []
    @pedidos_por_distribuidor = []
    @producto_pedidos = []

    Producto.all.each do |producto|
      @prueba = {:name => producto.nombre, :data => {}}
      @producto_historicos.each do |historico|
        if historico.producto_id == producto.id
          @linea = {:name => producto.nombre, data: {historico.created_at => historico.precio}}
          @prueba.deep_merge!(@linea)
        end
      end
    @historico << @prueba
    end

    Insumo.all.each do |insumo|
      @datos = {:name => insumo.nombre, :data => {}}
      @insumo_historicos.each do |historico|
        if historico.insumo_id == insumo.id
          @linea = {:name => insumo.nombre, data: {historico.created_at => historico.precio}}
          @datos.deep_merge!(@linea)
        end
      end
      @insumo_historico << @datos
    end

    distribuidores = Pedido.distinct.pluck(:distribuidor_id)
    distribuidores.each do |distribuidor|
      @data = []
      suma = Pedido.where(distribuidor_id: distribuidor).count
      @pedidos_por_distribuidor << [User.find(distribuidor).razonSocial, suma]
    end

    productos = Detalle.distinct.pluck(:producto_id)
    productos.each do |producto|
      @data = []
      suma = Detalle.where(producto_id: producto).count
      @producto_pedidos << [Producto.find(producto).nombre, suma]
    end

  end


  def evolucion_precios
    result = ProductoHistoricos.group_by(&:created_at).count
    render json: [{name: 'Count', data: result}]
  end

  # GET /producto_historicos/1
  # GET /producto_historicos/1.json
  def show
    authorize ProductoHistorico
  end

  # GET /producto_historicos/new
  def new
    @producto_historico = ProductoHistorico.new
    authorize @producto_historico
  end

  # GET /producto_historicos/1/edit
  def edit
    authorize ProductoHistorico
  end

  # POST /producto_historicos
  # POST /producto_historicos.json
  def create
    @producto_historico = ProductoHistorico.new(producto_historico_params)
    authorize @producto_historico
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
        authorize @producto_historico
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
    authorize @producto_historico
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
