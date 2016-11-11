class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]
  # GET /productos
  # GET /productos.json


  def index
     @productos = Producto.paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @productos = Producto.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @productos = Producto.all.paginate(:page => params[:page], :per_page => 10)
      end
      authorize @productos
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    authorize Producto
  end

  # GET /productos/new
  def new
    @producto = Producto.new
    authorize @producto
    @familia = Familium.all.collect {|x| [x.nombre, x.id]}
  end

  # GET /productos/1/edit
  def edit
    authorize Producto
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)
    authorize @producto
    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'El producto se genero correctamente' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        authorize @producto
        format.html { redirect_to @producto, notice: 'El producto se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    authorize @producto
    respond_to do |format|
      format.html { redirect_to productos_url, notice: 'El producto se elimino correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:nombre, :descripcion, :imagen, :precio, :activo, :familium_id, :rango,  :stock_fisico, :stock_reservado, :stock_disponible, :stock_pedido, :tipo)
    end

end
