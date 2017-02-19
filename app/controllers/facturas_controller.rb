class FacturasController < ApplicationController
  before_action :set_factura, only: [:show, :edit, :update, :destroy]
  before_action :set_tipo, only: [:show, :edit, :update, :new, :nueva_factura]
  before_action :set_numero, only: [:new, :nueva_factura]

  # GET /facturas
  # GET /facturas.json
  def index
    @facturas = Factura.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.pdf do
        send_data generate_pedidos_report(@facturas), filename: 'facturas.pdf',
                                                 type: 'application/pdf',
                                                 disposition: 'attachment'
      end
    end
    authorize @facturas
  end
  # GET /facturas/1
  # GET /facturas/1.json
  def show
  end

  # GET /facturas/new
  def new
    @factura = Factura.new
    @cuit = params[:cuit]
    authorize @factura
    crear_factura_sin_remito

    if !params[:cuit].nil?
      pedidos = Pedido.where(cuit: @cuit).pluck(:id)
      @remitos = Remito.where(pedido_id: [pedidos], facturado: false)
      puts("esto esta haciendo algo!!!!!")
      respond_to do |format|
        format.js { render "traer_remitos" }
      end
    else
      @remitos = Remito.where(:facturado => false)
    end
    #end      
  end

  def nueva_factura
    @factura = Factura.new
    authorize @factura
    @remitos_seleccionados = Remito.find(params[:remito_ids])
      @remitos_seleccionados.each do |remito|
        remito.remito_items.each do |obj|
          if obj.facturado == false or obj.facturado == nil
            if !@factura.producto_ids.include?(obj.producto_id)
              @factura.factura_items.build(:producto_id => obj.producto_id, :remito_id => remito.id)
            end
          end
        end
    end
    respond_to do |format|
      format.html {render "nueva_factura"}
    end
  end


  # GET /facturas/1/edit
  def edit
  end

  # POST /facturas
  # POST /facturas.json
  def create
    @factura = Factura.new(factura_params)
    authorize @factura
    #selecciono univocamente los ids de remitos que se asociaron
    #luego genero la asociacion a la factura

    respond_to do |format|
      if @factura.save
        @remitos = @factura.factura_items.distinct.pluck(:remito_id)
          @remitos.each do |remito|
            @remito = Remito.find(remito)
            @factura.remitos << @remito
          end


        actualizar_remito_item
        actualizar_estado_remito
        actualizar_estado_pedido
        format.html { redirect_to @factura, notice: 'Se creo la factura correctamente' }
        format.json { render :show, status: :created, location: @factura }
      else
        format.html { render :new }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facturas/1
  # PATCH/PUT /facturas/1.json
  def update
    respond_to do |format|
      if @factura.update(factura_params)
        authorize @factura
        format.html { redirect_to @factura, notice: 'Se actualizo la factura correctamente' }
        format.json { render :show, status: :ok, location: @factura }
      else
        format.html { render :edit }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facturas/1
  # DELETE /facturas/1.json
  def destroy
    @factura.destroy
    authorize @factura
    respond_to do |format|
      format.html { redirect_to facturas_url, notice: 'Se elimino la factura correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def crear_factura_sin_remito
      Producto.where(activo: true).all.each do |obj|
        if !@factura.producto_ids.include?(obj.id) #&& (obj.pendiente_facturar > 0)
          @factura.factura_items.build(:producto_id => obj.id)
        end
      end
   end
    # Use callbacks to share common setup or constraints between actions.
    def set_factura
      @factura = Factura.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def factura_params
      params.require(:factura).permit(:remito_id, :cuit, :fecha, :control, :vendedor, :subtotal, :bonificacion, :neto, :iva, :iibb, :total, :cae, :vencimiento_cae, :pto_venta, :numero, :tipo, :factura_items_attributes => [:id, :producto_id, :remito_id, :cantidad, :precio, :neto, :iva, :subtotal, :descuento, :_destroy])
    end

    def actualizar_remito_item
             @factura.factura_items.each do |factura_item|
        @factura.remitos.each do |remito|
          remito.remito_items.each do |remito_item|

            if (remito_item.producto_id == factura_item.producto_id) && (remito_item.remito_id == factura_item.remito_id)
              remito_item.pendiente_facturar -= factura_item.cantidad
              remito_item.save
            end
          end
        end
      end
    end

    def actualizar_estado_remito
      @factura.remitos.each do |remito|
        if remito.remito_items.all? {|producto| producto.pendiente_facturar == 0}
          remito.estado = "Facturado"
          remito.facturado = true
        else
          remito.estado = "Facturado parcial"
        end
        remito.save
      end
    end

    def actualizar_estado_pedido
      @factura.remitos.each do |remito|
        if remito.pedido.remitos.all? {|remito| remito.facturado?}
          remito.pedido.facturado!
          remito.pedido.facturado = true
        elsif remito.pedido.remitos.any? {|remito| remito.facturado? || remito.estado == "Pendiente" || remito.estado == "Facturado parcial"}
          remito.pedido.facturado_parcial!
        else
          remito.pedido.remitido!
        end
        remito.pedido.save
      end
    end

  def modificar_stock
    @factura.factura_items.each do |item|
      @remito = Remito.find(item.remito_id)
      @remito.remito_items.each do |producto|
        if producto.producto_id == item.producto_id && !item.cantidad.blank?
          producto.pendiente_facturar -= item.cantidad
          producto.save
        end
      end
    end
  end

  def modificar_stock_destruir
    @factura.factura_items.each do |item|
      @remito = Remito.find(item.remito_id)
      @remito.remito_items.each do |producto|
        if producto.producto_id == item.producto_id && !item.cantidad.blank?
          producto.pendiente_facturar += item.cantidad
          producto.save
        end
      end
    end
  end

  def set_numero
    if Factura.maximum(:numero)
      @numero = Factura.maximum(:numero) + 1
    else
      @numero = 1
    end
  end

  def set_tipo
    @tipos = ["Factura A", "Factura B"]
  end
end
