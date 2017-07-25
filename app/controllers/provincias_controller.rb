class ProvinciasController < ApplicationController
  before_action :set_provincia, only: [:show, :edit, :update, :destroy]

  # GET /provincias
  # GET /provincias.json
  def index
    @provincias = Provincia.paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @provincias = Provincia.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @provincias = Provincia.all.paginate(:page => params[:page], :per_page => 10)
      end
  end

  # GET /provincias/1
  # GET /provincias/1.json
  def show
  end

  # GET /provincias/new
  def new
    @provincia = Provincia.new
    @paises = Pais.all.collect {|x| [x.nombre, x.id]}

  end

  # GET /provincias/1/edit
  def edit
    @paises = Pais.all.collect {|x| [x.nombre, x.id]}
  end

  # POST /provincias
  # POST /provincias.json
  def create
    @provincia = Provincia.new(provincia_params)

    respond_to do |format|
      if @provincia.save
        format.html { redirect_to @provincia, notice: 'La provincia se creo correctamente.' }
        format.json { render :show, status: :created, location: @provincia }
      else
        format.html { render :new }
        format.json { render json: @provincia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provincias/1
  # PATCH/PUT /provincias/1.json
  def update
    respond_to do |format|
      if @provincia.update(provincia_params)
        format.html { redirect_to @provincia, notice: 'La provincia se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @provincia }
      else
        format.html { render :edit }
        format.json { render json: @provincia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provincias/1
  # DELETE /provincias/1.json
  def destroy
    @provincia.destroy
    respond_to do |format|
      format.html { redirect_to provincias_url, notice: 'La provincia se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provincia
      @provincia = Provincia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provincia_params
      params.require(:provincia).permit(:pais_id, :codigoAfip, :nombre, :nombre_corto)
    end
end
