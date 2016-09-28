class StockPedidosController < ApplicationController
  before_action :set_stock_pedido, only: [:show, :edit, :update, :destroy]

  # GET /stock_pedidos
  # GET /stock_pedidos.json
  def index
    @stock_pedidos = StockPedido.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /stock_pedidos/1
  # GET /stock_pedidos/1.json
  def show
  end

  # GET /stock_pedidos/new
  def new
    @stock_pedido = StockPedido.new
    crear_pedidos
  end

  # GET /stock_pedidos/1/edit
  def edit
  end

  # POST /stock_pedidos
  # POST /stock_pedidos.json
  def create
    @stock_pedido = StockPedido.new(stock_pedido_params)
    respond_to do |format|
      if @stock_pedido.save
        format.html { redirect_to @stock_pedido, notice: 'El pedido de stock se creo correctamente' }
        format.json { render :show, status: :created, location: @stock_pedido }
      else
        format.html { render :new }
        format.json { render json: @stock_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_pedidos/1
  # PATCH/PUT /stock_pedidos/1.json
  def update
    respond_to do |format|
        if @stock_pedido.update(stock_pedido_params)
        format.html { redirect_to @stock_pedido, notice: 'El pedido de stock se modifico correctamente.' }
        format.json { render :show, status: :ok, location: @stock_pedido }
      else
        format.html { render :edit }
        format.json { render json: @stock_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_pedidos/1
  # DELETE /stock_pedidos/1.json
  def destroy
    @stock_pedido.destroy
    respond_to do |format|
      format.html { redirect_to stock_pedidos_url, notice: 'El pedido de stock se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
      def crear_pedidos
        Producto.all.each do |obj|
          if !@stock_pedido.producto_ids.include?(obj.id)
            @stock_pedido.stock_items.build(:producto_id => obj.id)
          end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_pedido
      @stock_pedido = StockPedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_pedido_params
      params.require(:stock_pedido).permit(:vendedor, :cantidadTotal, :precioTotal, :stock_items_attributes => [:id, :producto_id, :cantidad, :precio, :recibido, :_destroy])
    end
end
