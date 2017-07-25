class DetalleInsumo < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :insumo, optional: true
	belongs_to :detalle, optional: true
	belongs_to :producto, optional: true

	after_create :crear_stock_en_insumos, :if => :cantidad_no_es_nula
	after_destroy :destruir_stock_en_insumos, :if => :cantidad_no_es_nula
	after_update :actualizar_stock_en_insumos



	def cantidad_no_es_nula
		return true if !self.cantidad_id.nil?
	end
	def cantidad_insumo
		coeficiente = ProductoInsumo.find_by(producto_id: self.producto_id, insumo_id: self.insumo_id).coeficiente
		self.cantidad_id = self.detalle.cantidad * coeficiente
	end

	def destruir_stock_en_insumos
		@insumo = Insumo.find(self.insumo_id)
		@insumo.stock_reservado -= self.cantidad_id 
		@insumo.stock_disponible += self.cantidad_id
		@insumo.save
	end

	def crear_stock_en_insumos
		@insumo = Insumo.find(self.insumo_id)
		@insumo.stock_reservado += self.cantidad_id 
		@insumo.stock_disponible -= self.cantidad_id
		@insumo.save
	end

	def actualizar_stock_en_insumos

		@insumo = Insumo.find(self.insumo_id)
		if self.cantidad_id_changed?
			puts("estoy actualizando el stock de los insumos")
			@insumo.stock_reservado -= self.cantidad_id_was 
			@insumo.stock_disponible += self.cantidad_id_was 
			@insumo.stock_reservado += self.cantidad_id  
			@insumo.stock_disponible -= self.cantidad_id
			@insumo.save
		end
	end

end
