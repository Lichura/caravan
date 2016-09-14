class MenuController < ApplicationController


	def index
		authorize :menu, :index?
	end

	def distribuidores
		authorize :menu, :distribuidores?
	end

end
