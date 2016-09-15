class CondicionPagosController < ApplicationController
  before_action :set_condicion_pago, only: [:show, :edit, :update, :destroy]

  # GET /condicion_pagos
  # GET /condicion_pagos.json
  def index
    @condicion_pagos = CondicionPago.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
        @condicion_pagos = CondicionPago.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @condicion_pagos = CondicionPago.all.paginate(:page => params[:page], :per_page => 10)
      end
  end

  # GET /condicion_pagos/1
  # GET /condicion_pagos/1.json
  def show
  end

  # GET /condicion_pagos/new
  def new
    @condicion_pago = CondicionPago.new
    @users = User.all
  end

  # GET /condicion_pagos/1/edit
  def edit
  end

  # POST /condicion_pagos
  # POST /condicion_pagos.json
  def create
    @condicion_pago = CondicionPago.new(condicion_pago_params)

    respond_to do |format|
      if @condicion_pago.save
        format.html { redirect_to @condicion_pago, notice: 'Condicion pago was successfully created.' }
        format.json { render :show, status: :created, location: @condicion_pago }
      else
        format.html { render :new }
        format.json { render json: @condicion_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condicion_pagos/1
  # PATCH/PUT /condicion_pagos/1.json
  def update
    respond_to do |format|
      if @condicion_pago.update(condicion_pago_params)
        format.html { redirect_to @condicion_pago, notice: 'Condicion pago was successfully updated.' }
        format.json { render :show, status: :ok, location: @condicion_pago }
      else
        format.html { render :edit }
        format.json { render json: @condicion_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condicion_pagos/1
  # DELETE /condicion_pagos/1.json
  def destroy
    @condicion_pago.destroy
    respond_to do |format|
      format.html { redirect_to condicion_pagos_url, notice: 'Condicion pago was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condicion_pago
      @condicion_pago = CondicionPago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condicion_pago_params
      params.require(:condicion_pago).permit(:user_id, :nombre, :descripcion, :dias)
    end
end
