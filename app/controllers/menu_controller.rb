class MenuController < ApplicationController
	before_filter :admin_required, except: [:distribuidores]
	before_filter :distribuidor_required, only: [:distribuidores]

	def index
	end

	def distribuidores
	end

end
