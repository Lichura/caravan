class PagosController < ApplicationController
  before_action :set_pago, only: [:show, :edit, :update, :destroy]
  before_action :set_tipos, only: [:new, :create, :show, :edit, :update, :destroy]
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
  end

  # GET /pagos/1
  # GET /pagos/1.json
  def show
  end

  # GET /pagos/new
  def new
    @pago = Pago.new
    @numerador = 0
    cheque = @pago.cheques.build
  end

  # GET /pagos/1/edit
  def edit
  end

  # POST /pagos
  # POST /pagos.json
  def create
    @pago = Pago.new(pago_params)

    respond_to do |format|
      if @pago.save
        format.html { redirect_to @pago, notice: 'Pago was successfully created.' }
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
        format.html { redirect_to @pago, notice: 'Pago was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to pagos_url, notice: 'Pago was successfully destroyed.' }
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

    def set_tipos
      @mediosDePago =["Efectivo", "Cheque"]
    end
end
