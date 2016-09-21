class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]


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
      if params[:search]
        @pedidos = Pedido.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @pedidos = Pedido.all.paginate(:page => params[:page], :per_page => 10)
      end
    authorize @pedidos
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show

  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
    authorize @pedido
    create_pedidos
    if Pedido.last.present?
      @numeroDePedido = (Pedido.last.id + 1) #si existe algun numero de pedido, utilizo el ultimo y le sumo 1
    else
      @numeroDePedido = 1 #sino existe, empiezo el numerador por 1
    end
    #@productos = Producto.all
    #@detalles = @pedido.detalles.build
    #@productos = @detalles.build_producto
    @usuarios = User.all
    @cuits = User.all.map{ |u| [ u.cuit, u.id ] }
    if params[:cliente_id]
    @cliente = User.find(params[:cliente_id])  #a partir del id seleccionado en la vista busco el cliente por ajax y lo renderizo con get_cliente
      respond_to do |format|
       format.js {render "get_cliente"}
      end
    end
  end

  # GET /pedidos/1/edit
  def edit
    @productos = Producto.all
    authorize @productos
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)
    authorize @pedido
    @pedido.estado = "A confirmar"
    @pedido.distribuidor_id = current_user.id
    respond_to do |format|
    pendiente_remision
      if @pedido.save
        params[:pedido][:detalles_attributes].each do |producto, params|
          @producto = Producto.find(params[:producto_id])
          @producto.stock_disponible -= params[:cantidad].to_i
          @producto.stock_reservado += params[:cantidad].to_i
          @producto.save
        end
        enviar_mensaje_por_slack

        format.html { redirect_to @pedido, notice: 'El pedido se creo correctamente' }
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
    estado = "Pendiente de remitir"
    params[:pedido][:detalles_attributes].each do |producto, params|
      if params[:rango_desde].empty? || params[:rango_hasta].empty?
        estado = "A confirmar"
      end
      @producto = Producto.find(params[:producto_id])
      @producto.stock_disponible -= params[:cantidad].to_i
      @producto.stock_reservado += params[:cantidad].to_i
      @producto.save
    end
    @pedido.detalles.each do |producto|
       @producto = Producto.find(producto.producto_id)
       @producto.stock_reservado -= producto.cantidad
       @producto.stock_disponible += producto.cantidad
       @producto.save
    end
    #con esta linea actualizo los valores de cantidad a pendiente de remitir

    @pedido.estado = estado

    respond_to do |format|
      if @pedido.update(pedido_params)
        @pedido.detalles.update_all "pendiente_remitir = cantidad"
        format.html { redirect_to @pedido, notice: 'El pedido se actualizo correctamente' }
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
        authorize @pedido
        @pedido.detalles.each do |producto|
         Producto.find(producto.id).stock_reservado -= producto.cantidad
         Producto.find(producto.id).stock_disponible += producto.cantidad
        end
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'El pedido se ha eliminado correctamente' }
      format.json { head :no_content }
    end
  end


  def nuevo_usuario
     @usuario = User.new
  end
  
  private
    def create_pedidos
      Producto.all.each do |obj|
        if !@pedido.producto_ids.include?(obj.id)
          @pedido.detalles.build(:producto_id => obj.id)
        end
    end
  end


    def pendiente_remision
      @pedido.detalles.each do |producto|
        producto.pendiente_remitir = producto.cantidad
      end
    end

    def enviar_mensaje_por_slack
       articulos = Hash.new
        params[:pedido][:detalles_attributes].each do |producto, params|
          nombre = Producto.find(params[:producto_id]).nombre
          articulos[nombre] = params[:cantidad]
        end

        mensaje = "Nuevo pedido del cliente #{User.find(@pedido.user_id).razonSocial}\n"
            articulos.each do |k,v|
            mensaje += "#{k}: #{v} unidades\n"
            end

      SLACK.ping mensaje , parse: "full"
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
        params.require(:pedido).permit(:fecha, :user_id, :cantidadTotal, :cuit, :precioTotal, :comprobanteNumero, :condicionCompra, :sucursal, :detalles_attributes => [:id, :precio, :cantidad, :producto_id, :rango_desde, :rango_hasta, :pendiente_remitir, :_destroy])
    end

end
