class Factura < ApplicationRecord
	has_and_belongs_to_many :remitos, optional: true
	has_many :factura_items
	has_many :productos, :through => :factura_items

	accepts_nested_attributes_for :factura_items,  allow_destroy: true

	after_initialize :aumentar_numerador
	before_validation :marcar_productos_para_destruir

	private
	def aumentar_numerador
		if Factura.maximum(:numero)
			self.numero = Factura.maximum(:numero)
		else
			self.numero = 1
		end
	end


	def marcar_productos_para_destruir
	    factura_items.each do |producto|
	      if producto.cantidad.blank? or (producto.cantidad == 0)
	        producto.mark_for_destruction
	      end
    	end
  	end
end
