class ChequesController < ApplicationController

	before_action :set_estados , only: [:index]
	def index
		@cheques = Cheque.all
	end

	def set_estados
		@estados= ["Recibido", "Acreditado", "Rechazado"]
	end

	def set_cheque
		@cheque = Cheque.find(params[:id])
	end
end
