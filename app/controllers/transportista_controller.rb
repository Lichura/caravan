class TransportistaController < ApplicationController
  before_action :set_transportistum, only: [:show, :edit, :update, :destroy]

  # GET /transportista
  # GET /transportista.json
  def index
    @transportista = Transportistum.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /transportista/1
  # GET /transportista/1.json
  def show
  end

  # GET /transportista/new
  def new
    @transportista = Transportistum.new
  end

  # GET /transportista/1/edit
  def edit
  end

  # POST /transportista
  # POST /transportista.json
  def create
    @transportista = Transportistum.new(transportistum_params)

    respond_to do |format|
      if @transportista.save
        format.html { redirect_to @transportista, notice: 'Transportistum was successfully created.' }
        format.json { render :show, status: :created, location: @transportista }
      else
        format.html { render :new }
        format.json { render json: @transportista.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportista/1
  # PATCH/PUT /transportista/1.json
  def update
    respond_to do |format|
      if @transportista.update(transportistum_params)
        format.html { redirect_to @transportista, notice: 'Transportistum was successfully updated.' }
        format.json { render :show, status: :ok, location: @transportista }
      else
        format.html { render :edit }
        format.json { render json: @transportista.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportista/1
  # DELETE /transportista/1.json
  def destroy
    @transportista.destroy
    respond_to do |format|
      format.html { redirect_to transportista_url, notice: 'Transportistum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportistum
      @transportista = Transportistum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transportistum_params
      params.require(:transportistum).permit(:nombre, :dni, :cuit, :destino, :numeroGuia, :dniRetira, :comentarios)
    end
end
