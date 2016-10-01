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
    @remitos = Remito.all
    crear_factura_sin_remito
  end

  def nueva_factura
    @factura = Factura.new
    @remitos_seleccionados = Remito.find(params[:remito_ids])
      @remitos_seleccionados.each do |remito|
        remito.remito_items.each do |obj|
          if !@factura.producto_ids.include?(obj.producto_id)
            @factura.factura_items.build(:producto_id => obj.producto_id, :remito_id => remito.id)
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

    respond_to do |format|
      if @factura.save
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
      params.require(:factura).permit(:cuit, :fecha, :control, :vendedor, :subtotal, :bonificacion, :neto, :iva, :iibb, :total, :cae, :vencimiento_cae, :pto_venta, :numero, :tipo, :factura_items_attributes => [:id, :producto_id, :remito_id, :cantidad, :precio, :neto, :iva, :subtotal, :descuento, :_destroy])
    end



  def set_tipo
    @tipos = ["Factura A", "Factura B"]
  end
end
