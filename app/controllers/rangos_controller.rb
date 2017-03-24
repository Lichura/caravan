class RangosController < ApplicationController
  before_action :set_rango, only: [:show, :edit, :update, :destroy]

  # GET /rangos
  # GET /rangos.json
  def index
    if params[:pedido]
      @rangos = Rango.where(pedido_id: params[:pedido]).paginate(:page => params[:page], :per_page => 10)
      @nombre = Pedido.find(params[:pedido]).comprobanteNumero
    else
      @rangos = Rango.paginate(:page => params[:page], :per_page => 10).includes(:user)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @rangos.to_csv }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"pedido-#{@nombre}.xls\"" }
    end
  end

  # GET /rangos/1
  # GET /rangos/1.json
  def show
  end

  # GET /rangos/new
  def new
    @rango = Rango.new
  end

  # GET /rangos/1/edit
  def edit
  end

  # POST /rangos
  # POST /rangos.json
  def create
    @rango = Rango.new(rango_params)

    respond_to do |format|
      if @rango.save
        format.html { redirect_to @rango, notice: 'Rango was successfully created.' }
        format.json { render :show, status: :created, location: @rango }
      else
        format.html { render :new }
        format.json { render json: @rango.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rangos/1
  # PATCH/PUT /rangos/1.json
  def update
    respond_to do |format|
      if @rango.update(rango_params)
        format.html { redirect_to @rango, notice: 'Rango was successfully updated.' }
        format.json { render :show, status: :ok, location: @rango }
      else
        format.html { render :edit }
        format.json { render json: @rango.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rangos/1
  # DELETE /rangos/1.json
  def destroy
    @rango.destroy
    respond_to do |format|
      format.html { redirect_to rangos_url, notice: 'Rango was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rango
      @rango = Rango.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rango_params
      params.require(:rango).permit(:letras, :numero, :digito, :pedido_id, :user_id)
    end
end
