class CuentaCorrienteController < ApplicationController
	authorize CuentaCorriente
	def index
		@cuentacorrientes = CuentaCorriente.order(created_at: :desc).paginate(:page => params[:page], :per_page => 50)
		if params[:cliente]
			@cuentacorrientes = CuentaCorriente.filtrar(params[:cliente], params[:fecha]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 50)
		else
			@cuentacorrientes = CuentaCorriente.order(created_at: :desc).paginate(:page => params[:page], :per_page => 50)
		end
	end

	private

end
