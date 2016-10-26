class PedidosController < ApplicationController

  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_action :estados, only: [:index]
  helper_method :sort_column, :sort_direction

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

    @pedidos = Pedido.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @pedidos = Pedido.search(params[:search]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
      else
        @pedidos = Pedido.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
      end

      if params[:filtrar] && params[:filtrar] != ""
        @estado = Pedido.statuses[params[:filtrar]]
        @pedidos = Pedido.filtrar(@estado).order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
      else
        @pedidos = Pedido.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
      end
    respond_to do |format|
      format.html
      format.pdf do
        send_data generate_pedidos_report(@pedidos), filename: 'pedidos.pdf',
                                                 type: 'application/pdf',
                                                 disposition: 'attachment'
      end
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
    @usuarios = User.all
    if Pedido.maximum(:comprobanteNumero)
      @numero = Pedido.maximum(:comprobanteNumero) + 1
    else
      @numero = 1
    end
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
    @pedido.distribuidor_id = current_user.id
    respond_to do |format|
    pendiente_remision
      if @pedido.save
        @pedido.activo!
        params[:pedido][:detalles_attributes].each do |producto, params|
          @producto = Producto.find(params[:producto_id])
          @producto.stock_disponible -= params[:cantidad].to_i
          @producto.stock_reservado += params[:cantidad].to_i
          @producto.save
        end
        #enviar_mensaje_por_slack

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
    params[:pedido][:detalles_attributes].each do |producto, params|
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
    respond_to do |format|
      if @pedido.update(pedido_params)
        estado_pedido_update
        actualizar_pedido_cuenta_corriente
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
         Producto.find(producto.producto_id).stock_reservado -= producto.cantidad
         Producto.find(producto.producto_id).stock_disponible += producto.cantidad
        end
      if !@pedido.remitos.any?
        @pedido.destroy
        respond_to do |format|
          format.html { redirect_to pedidos_url, notice: 'El pedido se elimino correctamente' }
          format.json { render :show, status: :ok, location: @pedido }
        end
      else
        respond_to do |format|
          format.html { redirect_to pedidos_url, alert: 'El pedido no puede ser eliminado ya que contiene remitos asociados.' }
          format.json { render :show, status: :error, location: @pedido }
        end
      end
  end


  def nuevo_usuario
     @usuario = User.new
  end
  
  private
    def estado_pedido_update
        if @pedido.detalles.any? { |item| Producto.find(item.producto_id).rango == true && (item.rango_desde.blank? || item.rango_hasta.blank?)}
          @pedido.activo!
        else
          @pedido.confirmado!
        end
    end

    def create_pedidos
      Producto.where(tipo: 1).all.each do |obj|
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



    def generate_remitos_report(pedidos)
      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'pedidos', 'list.tlf')

      pedidos.each do |pedido|
        report.list.add_row do |row|
          row.values no: pedido.id,
                     name: pedido.cuit
        end
      end

      report.generate
    end
      def estados
        @estados = ["activo","confirmado_parcial", "confirmado", "remitido", "remitido_parcial", "facturado_parcial", "facturado"]
      end

      def sort_column
        Pedido.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end
      
      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end
end
