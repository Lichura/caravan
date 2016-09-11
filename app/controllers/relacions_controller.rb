class RelacionsController < ApplicationController
  before_action :set_relacion, only: [:show, :edit, :update, :destroy]
  def edit

  end

  def index
   @relacions = Relacion.paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @relacions = Relacion.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @relacions = Relacion.all.paginate(:page => params[:page], :per_page => 10)
      end
  end

  def create
    @relacion = current_user.relacions.build(relacion_params)

      if @relacion.save
        format.html { redirect_to @relacion, notice: 'Detalle was successfully created.' }
        format.json { render :show, status: :created, location: @relacion }
      else
        format.html { render :new }
        format.json { render json: @relacion.errors, status: :unprocessable_entity }
      end

  end


  def destroy
    @relacion.destroy
    respond_to do |format|
      format.html { redirect_to relacions_url, notice: 'Se elimino la relacion correctamente' }
      format.json { head :no_content }
    end
  end


    def set_relacion
      @relacion = Relacion.find(params[:id])
    end
    def relacion_params
      params.require(:relacion).permit(:user_id, :cliente_id)
    end

end
