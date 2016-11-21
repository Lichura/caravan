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
		@pedidos = Pedido.activo.order(:created_at).limit(5).all
	
    @producto_historicos = ProductoHistorico.all
    @insumo_historicos = InsumoHistorico.all
    @detalle_producto = Detalle.all
    #@historico = ProductoHistorico.group(:producto_id).count 
    @pedidos_todos = Pedido.all
    @historico = []
    @ventas = []
    @insumo_historico = []
    @costo_insumo_historico = []
    @pedidos_por_distribuidor = []
    @producto_pedidos = []

    Producto.all.each do |producto|
      @prueba = {:name => producto.nombre, :data => {}}
      @producto_historicos.each do |historico|
        if historico.producto_id == producto.id
          @linea = {:name => producto.nombre, data: {historico.created_at => historico.precio}}
          @prueba.deep_merge!(@linea)
        end
      end
    @historico << @prueba
    end

    Insumo.all.each do |insumo|
      @datos = {:name => insumo.nombre, :data => {}}
      @insumo_historicos.each do |historico|
        if historico.insumo_id == insumo.id
          @linea = {:name => insumo.nombre, data: {historico.created_at => historico.precio}}
          @datos.deep_merge!(@linea)
        end
      end
      @insumo_historico << @datos
    end



    distribuidores = Pedido.distinct.pluck(:distribuidor_id)
    distribuidores.each do |distribuidor|
      @data = []
      suma = Pedido.where(distribuidor_id: distribuidor).count
      @pedidos_por_distribuidor << [User.find(distribuidor).razonSocial, suma]
    end

    productos = Detalle.distinct.pluck(:producto_id)
    productos.each do |producto|
      @data = []
      suma = Detalle.where(producto_id: producto).count
      @producto_pedidos << [Producto.find(producto).nombre, suma]
    end


	end

end
