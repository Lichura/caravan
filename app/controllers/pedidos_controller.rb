class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_filter :admin_required, :all
  before_filter :distribuidor_required,  only: :new
 
  def get_precios
    @producto = Producto.find params[:producto_id]
    @precio = @producto.precio
  end

  def get_cliente
    @cliente = User.find(params[:cliente_id])
    respond_to do |format|
     format.js { render 'get_cliente', layout: false}
    end
  end

  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.paginate(:page => params[:page], :per_page => 10)

  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show

  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
    create_pedidos
    if Pedido.last.present?
      @numeroDePedido = (Pedido.last.id + 1)
    else
      @numeroDePedido = 1
    end
    #@productos = Producto.all
    #@detalles = @pedido.detalles.build
    #@productos = @detalles.build_producto
    @usuarios = User.all
    @cuits = User.all.map{ |u| [ u.cuit, u.id ] }
    if params[:cliente_id]
    @cliente = User.find(params[:cliente_id])
      respond_to do |format|
       format.js {render "get_cliente"}
      end
    end
  end

  # GET /pedidos/1/edit
  def edit
    @productos = Producto.all

  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)
    respond_to do |format|
      if @pedido.save
        params[:pedido][:detalles_attributes].each do |producto, params|
          @producto = Producto.find(params[:producto_id])
          @producto.stock_disponible = params[:cantidad].to_i
          @producto.save
        end
        enviar_mensaje_por_slack

        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update

    respond_to do |format|
      if @pedido.update(pedido_params)
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @pedido }
      else
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
        @pedido.detalles.each do |producto|
         Producto.find(producto.id).stock_reservado = producto.cantidad
         Producto.find(producto.id).stock_disponible = producto.cantidad
        end
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_pedidos
      Producto.all.each do |obj|
        if !@pedido.producto_ids.include?(obj.id)
          @pedido.detalles.build(:producto_id => obj.id)
        end
    end
  end


  private

  def enviar_mensaje_por_slack
       articulos = Hash.new
        params[:pedido][:detalles_attributes].each do |producto, params|
          nombre = Producto.find(params[:producto_id]).nombre
          articulos[nombre] = params[:cantidad]
        end
            SLACK.ping "Nuevo pedido del cliente: #{User.find(@pedido.user_id).razonSocial}\n
            Articulos: #{articulos}
", parse: "full"
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    #def pedido_params
    #  params.require(:pedido).permit(:fecha, :cantidadTotal, :tipo, :titular, :cuit, :precioTotal, :remitido, :facturado, :comprobanteNumero, :condicionCompra, :sucursal, :producto_ids => [])
    #end

    def pedido_params
        params.require(:pedido).permit(:fecha, :user_id, :cantidadTotal, :cuit, :precioTotal, :comprobanteNumero, :condicionCompra, :sucursal, :detalles_attributes => [:id, :_destroy, :precio, :cantidad, :producto_id])
    end

end
