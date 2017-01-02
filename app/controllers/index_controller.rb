class IndexController < ApplicationController
	skip_before_action :require_login
	def index
		@mensaje = Mensaje.new
		@pagina_principal = PaginaPrincipal.first
	end
end