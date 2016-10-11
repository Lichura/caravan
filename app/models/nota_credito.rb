class NotaCredito < ApplicationRecord
	has_many :productos, through: :nota_credito_items
	has_many :nota_credito_items

	accepts_nested_attributes_for :nota_credito_items,  allow_destroy: true
	before_validation :marcar_productos_para_destruir

	def marcar_productos_para_destruir
	    nota_credito_items.each do |producto|
	      if producto.cantidad.blank? or (producto.cantidad == 0)
	        producto.mark_for_destruction
	      end
    	end
  	end


end
