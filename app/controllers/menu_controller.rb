class MenuController < ApplicationController


	def index
		authorize :menu, :index?
		@mensajes = Mensaje.where(leido: false).count
	end

	def distribuidores
		authorize :menu, :distribuidores?
	end

end
