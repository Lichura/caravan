class IndexController < ApplicationController
	skip_before_filter :require_login
	def index
		@mensaje = Mensaje.new
	end
end