class MenuController < ApplicationController


	def index
		authorize :menu, :index?
		@mensajes = Mensaje.where(leido: false).count

	end

	def distribuidores
		authorize :menu, :distribuidores?
	end

	def dashboard
		@insumos = Insumo.where('stock_fisico < alerta').all 
		@pedidos = Pedido.activo.all
	end

end
