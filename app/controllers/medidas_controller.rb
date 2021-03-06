class MedidasController < ApplicationController
  before_action :set_medida, only: [:show, :edit, :update, :destroy]

  # GET /medidas
  # GET /medidas.json
  def index
    @medidas = Medida.paginate(:page => params[:page], :per_page => 10)
    authorize @medidas
  end

  # GET /medidas/1
  # GET /medidas/1.json
  def show
  end

  # GET /medidas/new
  def new
    @medida = Medida.new
    authorize @medida
  end

  # GET /medidas/1/edit
  def edit
  end

  # POST /medidas
  # POST /medidas.json
  def create
    @medida = Medida.new(medida_params)
    authorize @medida
    respond_to do |format|
      if @medida.save
        format.html { redirect_to @medida, notice: 'Se creo la medida correctamente' }
        format.json { render :show, status: :created, location: @medida }
      else
        format.html { render :new }
        format.json { render json: @medida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medidas/1
  # PATCH/PUT /medidas/1.json
  def update
    respond_to do |format|
      if @medida.update(medida_params)
        authorize @medida
        format.html { redirect_to @medida, notice: 'Se actualizo la medida correctamente' }
        format.json { render :show, status: :ok, location: @medida }
      else
        format.html { render :edit }
        format.json { render json: @medida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medidas/1
  # DELETE /medidas/1.json
  def destroy
    @medida.destroy
    authorize @medida
    respond_to do |format|
      format.html { redirect_to medidas_url, notice: 'Se elimino la medida correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medida
      @medida = Medida.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medida_params
      params.require(:medida).permit(:codigoAfip, :nombre, :abreviatura, :descripcion)
    end
end
