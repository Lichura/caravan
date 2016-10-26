class NotaCreditosController < ApplicationController
  before_action :set_nota_credito, only: [:show, :edit, :update, :destroy]
  before_action :set_tipo, only: [:new, :show, :edit, :update, :destroy]
  # GET /nota_creditos
  # GET /nota_creditos.json
  def index
    @nota_creditos = NotaCredito.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /nota_creditos/1
  # GET /nota_creditos/1.json
  def show
  end

  # GET /nota_creditos/new
  def new
    @nota_credito = NotaCredito.new
    crear_productos
  end

  # GET /nota_creditos/1/edit
  def edit
  end

  # POST /nota_creditos
  # POST /nota_creditos.json
  def create
    @nota_credito = NotaCredito.new(nota_credito_params)

    respond_to do |format|
      if @nota_credito.save
        format.html { redirect_to @nota_credito, notice: 'Nota credito was successfully created.' }
        format.json { render :show, status: :created, location: @nota_credito }
      else
        format.html { render :new }
        format.json { render json: @nota_credito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nota_creditos/1
  # PATCH/PUT /nota_creditos/1.json
  def update
    respond_to do |format|
      if @nota_credito.update(nota_credito_params)
        format.html { redirect_to @nota_credito, notice: 'Nota credito was successfully updated.' }
        format.json { render :show, status: :ok, location: @nota_credito }
      else
        format.html { render :edit }
        format.json { render json: @nota_credito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nota_creditos/1
  # DELETE /nota_creditos/1.json
  def destroy
    @nota_credito.destroy
    respond_to do |format|
      format.html { redirect_to nota_creditos_url, notice: 'Nota credito was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota_credito
      @nota_credito = NotaCredito.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nota_credito_params
      params.require(:nota_credito).permit(:numero, :cliente_id, :factura_id, :distribuidor_id, :vendedor_id, :fecha, :estado, :tipo, :neto, :iva, :total, :tipo, :nota_credito_items_attributes => [:id, :producto_id, :cantidad, :precio, :neto, :iva, :subtotal,  :_destroy])
    end

  def crear_productos
      Producto.all.each do |obj|
        if !@nota_credito.producto_ids.include?(obj.id)
          @nota_credito.nota_credito_items.build(:producto_id => obj.id)
        end
    end
  end


     
   def set_tipo
      @tipos = ["Nota de credito", "Nota de debito"]
    end
end
