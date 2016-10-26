class NotaCredito < ApplicationRecord
	enum estado: {
	    activo: 0,
	    confirmado: 1, 
	    anulado: 2
	    }

	has_many :productos, through: :nota_credito_items
	has_many :nota_credito_items

	accepts_nested_attributes_for :nota_credito_items,  allow_destroy: true
	before_validation :marcar_productos_para_destruir
	after_create :estado_inicial
	after_create :nueva_factura_cuenta_corriente

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

  	 def nueva_factura_cuenta_corriente
  	 	if self.tipo == 0 
		    @cc = CuentaCorriente.new
		    @cc.user_id = self.distribuidor_id
		    @cc.monto =  self.total
		    @cc.concepto = "Se creo la nota de credito Nº #{self.numero}"
		    @cc.conceptoNumero = self.numero
		    @cc.save
		elsif self.tipo == 1
		    @cc = CuentaCorriente.new
		    @cc.user_id = self.distribuidor_id
		    @cc.monto =  -1 * (self.total)
		    @cc.concepto = "Se creo la nota de debito Nº #{self.numero}"
		    @cc.conceptoNumero = self.numero
		    @cc.save
		end
 	 end
end
