class CiudadesController < ApplicationController
  before_action :set_ciudad, only: [:show, :edit, :update, :destroy]
  # GET /ciudades
  # GET /ciudades.json
  def index
    @ciudades = Ciudad.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
        @ciudades = Ciudad.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @ciudades = Ciudad.all.paginate(:page => params[:page], :per_page => 10)
      end
      authorize @ciudades
  end

  # GET /ciudades/1
  # GET /ciudades/1.json
  def show
    @provincias = Provincia.all
    @paises = Pais.all
  end

  # GET /ciudades/new
  def new
    @ciudad = Ciudad.new
    authorize @ciudad
    @paises = Pais.all.collect {|x| [x.nombre, x.id]}
  end

  # GET /ciudades/1/edit
  def edit
    @paises = Pais.all.collect {|x| [x.nombre, x.id]}
  end

  # POST /ciudades
  # POST /ciudades.json
  def create
    @ciudad = Ciudad.new(ciudad_params)
    authorize @ciudad
    respond_to do |format|
      if @ciudad.save
        format.html { redirect_to @ciudad, notice: 'La ciudad se creo correctamente' }
        format.json { render :show, status: :created, location: @ciudad }
      else
        format.html { render :new }
        format.json { render json: @ciudad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ciudades/1
  # PATCH/PUT /ciudades/1.json
  def update
    respond_to do |format|
      if @ciudad.update(ciudad_params)
        authorize @ciudad
        format.html { redirect_to @ciudad, notice: 'La ciudad se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @ciudad }
      else
        format.html { render :edit }
        format.json { render json: @ciudad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ciudades/1
  # DELETE /ciudades/1.json
  def destroy
    @ciudad.destroy
    authorize @ciudad
    respond_to do |format|
      format.html { redirect_to ciudades_url, notice: 'La ciudad se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ciudad
      @ciudad = Ciudad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ciudad_params
      params.require(:ciudad).permit(:pais_id, :provincia_id, :nombre, :nombre_corto)
    end
end
