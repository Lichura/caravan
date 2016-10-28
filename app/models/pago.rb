class Pago < ApplicationRecord
	has_many :cheques
	accepts_nested_attributes_for :cheques,  allow_destroy: true
	after_create :impactar_cuenta_corriente
	before_validation :marcar_productos_para_destruir
	after_initialize :aumentar_numerador

	validates :distribuidor_id, presence: true
	
	
	private
	def impactar_cuenta_corriente
		if self.medioDePago == "Efectivo" or self.medioDePago == 0
				distribuidor = User.find(self.distribuidor_id)
			    @cc = CuentaCorriente.new
			    @cc.user_id = distribuidor.id
			    @cc.monto =  -1 * (self.monto)
			    @cc.concepto = "Se genero el pago en efectivo Nº #{self.numero}"
			    @cc.conceptoNumero = self.numero
			    @cc.save
		end
	end

	def marcar_productos_para_destruir
	    cheques.each do |cheque|
	      if cheque.monto.blank? or (cheque.monto == 0)
	        cheque.mark_for_destruction
	      end
    	end
  	end


  	def aumentar_numerador
		if Pago.maximum(:numero)
			self.numero = Pago.maximum(:numero) + 1
		else
			self.numero = 1
		end
	end
end
