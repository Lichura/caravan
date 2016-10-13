class NotaCredito < ApplicationRecord
		enum estados = {confirmado: 1,
					    anulado: 2}

	has_many :productos, through: :nota_credito_items
	has_many :nota_credito_items

	accepts_nested_attributes_for :nota_credito_items,  allow_destroy: true
	before_validation :marcar_productos_para_destruir
	after_create :estado_inicial

	def marcar_productos_para_destruir
	    nota_credito_items.each do |producto|
	      if producto.cantidad.blank? or (producto.cantidad == 0)
	        producto.mark_for_destruction
	      end
    	end
  	end

  	def estado_inicial
  		self.confirmado!
  	end
end
