class Detalle < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :producto, optional: true
	belongs_to :pedido, optional: true
	#after_create :controlar_stock
	after_update :actualizar_stock_insumo
	before_destroy :destruir_stock_insumo

  	has_many :detalle_insumos
  	accepts_nested_attributes_for :detalle_insumos,  allow_destroy: true

	def controlar_stock
		producto = Producto.find(self.producto_id)
		if self.cantidad > producto.stock_disponible
			puts( "El stock para el articulo #{producto.nombre} es insuficiente")
		end
	end

	def destruir_stock_insumo
	      producto = Producto.find(self.producto_id)
	      producto.producto_insumos.each do |insumo|
	        insumos = Insumo.find(insumo.insumo_id)
	          insumos.stock_disponible += (self.cantidad_was * insumo.coeficiente)
	          insumos.stock_reservado -= (self.cantidad_was  * insumo.coeficiente)
	        insumos.save
	      end
	end

  def actualizar_stock_insumo
      if self.cantidad_changed?
      	  self.detalle_insumos do |detalle|
	      producto = Producto.find(detalle.producto_id)
	      insumo = Insumo.find(detalle.insumo_id)
	      coeficiente = ProductoInsumo.find_by(producto_id: producto.id, insumo_id: insumo.id).coeficiente
	          insumo.stock_disponible += (self.cantidad_was * coeficiente)
	          insumo.stock_reservado -= (self.cantidad_was  * coeficiente)
	          insumo.stock_disponible -= (self.cantidad * coeficiente)
	          insumo.stock_reservado += (self.cantidad  * icoeficiente)
	        insumo.save
	      end
      end
  end



end
