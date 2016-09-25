class RemitosController < ApplicationController
  before_action :set_remito, only: [:show, :edit, :update, :destroy]


  # GET /remitos
  # GET /remitos.json
  def index
    @remitos = Remito.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
        @remitos = Remito.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @remitos = Remito.all.paginate(:page => params[:page], :per_page => 10)
      end

  end

  # GET /remitos/1
  # GET /remitos/1.json
  def show
  end

  # GET /remitos/new
  def new
    @remito = Remito.new
    @pedido = Pedido.find(params[:id])     
    create_remitos
  end

  # GET /remitos/1/edit
  def edit
  end

  # POST /remitos
  # POST /remitos.json
  def create
    @remito = Remito.new(remito_params)
    modificar_estado
    modificar_stock

    respond_to do |format|
      if @remito.save
        finalizado_por_ajuste
        format.html { redirect_to @remito, notice: 'Remito was successfully created.' }
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
    respond_to do |format|
      if @remito.update(remito_params)
        finalizado_por_ajuste
        format.html { redirect_to @remito, notice: 'Remito was successfully updated.' }
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
    @remito.destroy
    respond_to do |format|
      format.html { redirect_to remitos_url, notice: 'Remito was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def finalizado_por_ajuste
    if @remito.finalizado
      @pedido.estado = "Finalizado por ajuste - Pendiente de facturar"
      @pedido.save
    end
  end

  def modificar_estado
        @pedido = Pedido.find(@remito.pedido_id)
        @pedido.estado = "Remitido - Pendiente de facturar"
        @pedido.save
  end

  def modificar_stock
    @pedido = Pedido.find(@remito.pedido_id)
    @pedido.detalles.each do |producto|
      @remito.remito_items.each do |item|
        if producto.producto_id = item.producto_id
          producto.pendiente_remitir -= item.cantidad
        end
      end
    end
    @pedido.save
  end

   def create_remitos
        @pedido.detalles.each do |obj|
          if !@remito.producto_ids.include?(obj.producto_id)
            @remito.remito_items.build(:producto_id => obj.producto_id)
          end
      end
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_remito
      @remito = Remito.find(params[:id]) 
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def remito_params
      params.require(:remito).permit(:pedido_id, :numero, :fecha, :transporte, :ivaTotal, :total, :cantidadTotal, :finalizado, :remito_items_attributes => [:id, :producto_id, :cantidad, :precio, :iva, :subtotal, :precioNeto, :_destroy])
    end
end
