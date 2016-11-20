class PagosController < ApplicationController
  before_action :set_pago, only: [:show, :edit, :update, :destroy]

  # GET /pagos
  # GET /pagos.json
  def index
    @pagos = Pago.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.pdf do
        send_data generate_pedidos_report(@pagos), filename: 'recibos.pdf',
                                                 type: 'application/pdf',
                                                 disposition: 'attachment'
      end
    end
    authorize @pagos
  end

  # GET /pagos/1
  # GET /pagos/1.json
  def show
    authorize Pago
  end

  # GET /pagos/new
  def new
    @pago = Pago.new
    authorize @pago
    @distribuidores = User.where(profile_id: 2).all
    @pago.aumentar_numerador
    cheque = @pago.cheques.build
  end

  # GET /pagos/1/edit
  def edit
    @distribuidores = User.where(profile_id: 2).all
  end

  # POST /pagos
  # POST /pagos.json
  def create
    @pago = Pago.new(pago_params)
    authorize @pago
    respond_to do |format|
      if @pago.save
        format.html { redirect_to @pago, notice: 'Se creo el pago de manera exitosa.' }
        format.json { render :show, status: :created, location: @pago }
      else
        format.html { render :new }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagos/1
  # PATCH/PUT /pagos/1.json
  def update
    respond_to do |format|
      if @pago.update(pago_params)
        authorize @pago
        format.html { redirect_to @pago, notice: 'Se actualizo el pago de manera exitosa.' }
        format.json { render :show, status: :ok, location: @pago }
      else
        format.html { render :edit }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagos/1
  # DELETE /pagos/1.json
  def destroy
    @pago.destroy
    authorize @pago
    respond_to do |format|
      format.html { redirect_to pagos_url, notice: 'Se elimino el pago de manera exitosa.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pago
      @pago = Pago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pago_params
      params.require(:pago).permit(:distribuidor_id, :numero, :medioDePago, :monto, :estado, :cheques_attributes => [:id, :monto, :banco, :numero, :fecha, :_destroy ])
    end


end
