class ChequesController < ApplicationController
	def index
		@cheques = Cheque.all
	end
end
