class NumeradorsController < ApplicationController
  before_action :set_numerador, only: [:show, :edit, :update, :destroy]

  # GET /numeradors
  # GET /numeradors.json
  def index
    @numeradors = Numerador.all
  end

  # GET /numeradors/1
  # GET /numeradors/1.json
  def show
  end

  # GET /numeradors/new
  def new
    @numerador = Numerador.new
  end

  # GET /numeradors/1/edit
  def edit
  end

  # POST /numeradors
  # POST /numeradors.json
  def create
    @numerador = Numerador.new(numerador_params)

    respond_to do |format|
      if @numerador.save
        format.html { redirect_to @numerador, notice: 'Numerador was successfully created.' }
        format.json { render :show, status: :created, location: @numerador }
      else
        format.html { render :new }
        format.json { render json: @numerador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /numeradors/1
  # PATCH/PUT /numeradors/1.json
  def update
    respond_to do |format|
      if @numerador.update(numerador_params)
        format.html { redirect_to @numerador, notice: 'Numerador was successfully updated.' }
        format.json { render :show, status: :ok, location: @numerador }
      else
        format.html { render :edit }
        format.json { render json: @numerador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /numeradors/1
  # DELETE /numeradors/1.json
  def destroy
    @numerador.destroy
    respond_to do |format|
      format.html { redirect_to numeradors_url, notice: 'Numerador was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_numerador
      @numerador = Numerador.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def numerador_params
      params.require(:numerador).permit(:comprobante, :puntoDeVenta, :numero)
    end
end
