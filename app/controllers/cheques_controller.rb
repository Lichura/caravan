class ChequesController < ApplicationController

	before_action :set_estados , only: [:index]
	before_action :set_cheque, only: [:show, :edit, :update, :destroy]
	
	def index
		@cheques = Cheque.all
	end


	def edit
	end

	def update_multiple
	@cheque = Cheque.update(params[:cheques].keys, params[:cheques].values)
		 @cheque.reject! { |u| u.errors.empty? }
		  if @cheque.empty?
		    redirect_to cheques_url
		  else
		    redirect_to cheques_url
		  end
	end


def update
    respond_to do |format|
      if @cheque.update(cheque_params)
        format.html { redirect_to cheques_url, notice: 'El usuario se actualizo correctamente' }
        format.json { render :show, status: :ok, location: @cheque }
      else
        format.html { render :index }
        format.json { render json: @cheque.errors, status: :unprocessable_entity }
      end
    end
  end

    def destroy
    @cheque.destroy
    respond_to do |format|
      format.html { redirect_to ciudades_url, notice: 'Se elimino el cheque correctamente' }
      format.json { head :no_content }
    end
  end

  private

	def set_estados
		@estados= [ "Recibido",  "Acreditado", "Rechazado"]
	end

	def set_cheque
		@cheque = Cheque.find(params[:id])
	end

	def set_multiple_ids
      params[:cheques_ids]
    end

    def cheque_params
		params.require(:cheque).permit(:monto, :numero, :fecha, :estado)
	end
end
