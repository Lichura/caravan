class RemitosController < ApplicationController
  before_action :set_remito, only: [:show, :edit, :update, :destroy]
  before_action :set_transporte

  # GET /remitos
  # GET /remitos.json
  def index
    @remitos = Remito.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
        @remitos = Remito.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @remitos = Remito.all.paginate(:page => params[:page], :per_page => 10)
      end
    respond_to do |format|
      format.html
      format.pdf do
        send_data generate_pedidos_report(@remitos), filename: 'remitos.pdf',
                                                 type: 'application/pdf',
                                                 disposition: 'attachment'
      end
    end
    authorize @remitos
  end

  # GET /remitos/1
  # GET /remitos/1.json
  def show
    @prueba = @remito.remito_items.all? {|item| item.facturado == true }
    authorize Remito
  end

  #esto es para la llamada desde un pedido, que muestre todos los remitos asociados
  def show_all
    authorize Remito
    @pedido = Pedido.find(params[:pedido])
    respond_to do |format|
      format.html {render "show_all"}
    end
  end

  # GET /remitos/new
  def new 
    #if params[:pedido_id]
      @pedido = Pedido.find(params[:pedido_id])
      @remito = Remito.new
      crear_remitos
    #else
      #@remito = Remito.new
      #crear_remitos_sin_pedido
    #end
    authorize @remito
    if params[:transporte]
     @transporte_elegido = @transporte_fields[params[:transporte]]  #a partir del id seleccionado en la vista busco el cliente por ajax y lo renderizo con get_cliente
      respond_to do |format|
       format.js {render "get_transporte"}
      end
    end
    @clientes = User.all
  end



  # GET /remitos/1/edit
  def edit
    authorize Remito
    @pedido = @remito.pedido
    @numero = @remito.numero
  end

  # POST /remitos
  # POST /remitos.json
  def create
    @remito = Remito.new(remito_params)
    authorize @remito
    respond_to do |format|
      if @remito.save
        format.html { redirect_to pedidos_path, notice: 'El remito se creo correctamente' }
        format.json { render :show, status: :created, location: @remito }
      else
        format.html { render :new }
        format.json { render json: @remito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remitos/1
  # PATCH/PUT /remitos/1.json
  def update
    #modificar_stock

    respond_to do |format|
      if @remito.update(remito_params)
        authorize @remito
        #estado_pedido_remito
        format.html { redirect_to @remito, notice: 'El remito se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @remito }
      else
        format.html { render :edit }
        format.json { render json: @remito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remitos/1
  # DELETE /remitos/1.json
  def destroy
    modificar_stock_destruir
    @remito.destroy
    authorize @remito
    estado_pedido_remito
    respond_to do |format|
      format.html { redirect_to remitos_url, notice: 'El remito se elimino correctamente' }
      format.json { head :no_content }
    end
  end

  private
  def set_transporte
  @transporte = ["Retira Cliente", "Retira distribuidor", "Envío por correo", "Envío por transporte", "Otros"]
  @transporte_fields = {"Retira Cliente" => [[:empresa, "Empresa"], [:dniRetira, "DNI retira"], [:telefono, "Telefono"]],
                          "Retira distribuidor" => [[:empresa, "Empresa"], [:dniRetira, "DNI retira"], [:telefono, "Telefono"]],
                          "Envío por correo" => [[:empresa, "Empresa"], [:destino, "Destino"], [:numeroGuia, "Numero Guia"], [:retira, "Retira"], [:dniRetira, "DNI Retira"]],
                          "Envío por transporte" => [[:empresa, "Empresa"], [:destino, "Destino"], [:numeroGuia, "Numero Guia"], [:retira, "Retira"], [:dniRetira, "DNI Retira"]],
                          "Otros" => [[:comentarios, "Comentarios"]]}
  end



  def crear_remitos
    @pedido.detalles.each do |obj|
      if !@remito.producto_ids.include?(obj.producto_id) && (obj.pendiente_remitir > 0)
        @remito.remito_items.build(:producto_id => obj.producto_id, :cantidad => obj.cantidad, :pendiente => obj.pendiente_remitir)
      end
    end
  end

  def crear_remitos_sin_pedido
    Producto.where(activo: true).all.each do |obj|
          @remito.remito_items.build(:producto_id => obj.id)
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_remito
      @remito = Remito.find(params[:id]) 
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def remito_params
      params.require(:remito).permit(:pedido_id, :numero, :fecha, :transporte, :ivaTotal, :total, :cantidadTotal, :finalizado, :empresa, :dniRetira, :telefono, :numeroGuia, :destino, :retira, :comentarios, :user_id, :remito_items_attributes => [:id, :producto_id, :cantidad, :precio, :iva, :subtotal, :precioNeto, :_destroy])
    end

end
