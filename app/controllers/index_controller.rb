class IndexController < ApplicationController
	def index
		@mensaje = Mensaje.new
	end
end