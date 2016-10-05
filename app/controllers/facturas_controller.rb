class FacturasController < ApplicationController
  before_action :set_factura, only: [:show, :edit, :update, :destroy]
  before_action :set_tipo, only: [:show, :edit, :update, :new, :nueva_factura]
  # GET /facturas
  # GET /facturas.json
  def index
    @facturas = Factura.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /facturas/1
  # GET /facturas/1.json
  def show
  end

  # GET /facturas/new
  def new
    @factura = Factura.new
    crear_factura_sin_remito
    @remitos = Remito.where(:facturado => false, :facturado => nil)
    #end
      
  end

  def nueva_factura
    @factura = Factura.new
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
    #selecciono univocamente los ids de remitos que se asociaron
    #luego genero la asociacion a la factura
    @remitos = @factura.factura_items.uniq.pluck(:remito_id)
    @remitos.each do |remito|
      @remito = Remito.find(remito)
      @factura.remitos << @remito
    end

    respond_to do |format|
      if @factura.save
        actualizar_estado
        format.html { redirect_to @factura, notice: 'Factura was successfully created.' }
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
        actualizar_estado
        format.html { redirect_to @factura, notice: 'Factura was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to facturas_url, notice: 'Factura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def crear_factura_sin_remito
      Producto.all.each do |obj|
        if !@factura.producto_ids.include?(obj.id)
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

    def actualizar_estado
      @remitos = @factura.factura_items.uniq.pluck(:remito_id)
      @remitos.each do |remito|
        @remito = Remito.find(remito)
        @pedido = Pedido.find(@remito.pedido_id)
        if @remito.remito_items.all? {|item| item.facturado?}
          @remito.estado = "Facturado"
          @remito.facturado = true
        elsif @remito.remito_items.any? {|item| item.facturado?}
          @remito.estado = "Facturado parcial"
        else
          @remito.estado = "Pendiente"
        end
        @remito.save

        if @pedido.remitos.all? {|remito| remito.facturado?}
          @pedido.facturado!
        elsif @pedido.remitos.any? {|remito| remito.facturado? || remito.estado == "Pendiente" || remito.estado == "Facturado parcial"}
          @pedido.facturado_parcial!
        else
          @pedido.remitido!
        end
      end
    end

  def set_tipo
    @tipos = ["Factura A", "Factura B"]
  end
end
