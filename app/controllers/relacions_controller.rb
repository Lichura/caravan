class RelacionsController < ApplicationController

  def edit

  end

  def index
   @relacions = Relacion.paginate(:page => params[:page], :per_page => 10)
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
  end


  def destroy
    @relacion = Relacion.find(params[:id])
    @relacion.destroy
    flash[:notice] = "Se elimino la relacion correctamente"
    redirect_to root_url
  end

    def relacion_params
      params.require(:relacion).permit(:user_id, :cliente_id)
    end

end
