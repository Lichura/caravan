class Pago < ApplicationRecord
	has_many :cheques
	accepts_nested_attributes_for :cheques,  allow_destroy: true
	after_create :impactar_cuenta_corriente

	def impactar_cuenta_corriente
		if self.tipo == 0 
				distribuidor = User.find(self.distribuidor_id)
			    @cc = CuentaCorriente.new
			    @cc.user_id = distribuidor.id
			    @cc.monto =  -1 * (self.monto)
			    @cc.concepto = "Se genero el pago en efectivo Nº #{self.numero}"
			    @cc.conceptoNumero = self.numero
			    @cc.save
		end
	end
end
