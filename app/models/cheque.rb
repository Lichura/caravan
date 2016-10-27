class Cheque < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :pago, optional: true
	after_update :actualizar_cuenta_corriente
	after_create :impactar_cuenta_corriente

	def actualizar_cuenta_corriente
		if self.rechazado_changed?
			if self.rechazado?
				distribuidor = User.find(self.pago.distribuidor_id)
			    @cc = CuentaCorriente.new
			    @cc.user_id = distribuidor.id
			    @cc.monto =  self.monto
			    @cc.concepto = "Se rechazo el cheque Nº #{self.numero}"
			    @cc.conceptoNumero = self.numero
			    @cc.save
			else
				distribuidor = User.find(self.pago.distribuidor_id)
			    @cc = CuentaCorriente.new
			    @cc.user_id = distribuidor.id
			    @cc.monto = -1 * (self.monto)
			    @cc.concepto = "Se quito el rechazo del cheque Nº #{self.numero}"
			    @cc.conceptoNumero = self.numero
			    @cc.save
			end	
		end
	end

	def impactar_cuenta_corriente
		distribuidor = User.find(self.pago.distribuidor_id)
		@cc = CuentaCorriente.new
		@cc.user_id = distribuidor.id
		@cc.monto =  -1 * (self.monto)
		@cc.concepto = "Se recibio el cheque Nº #{self.numero} correspondiente al pago Nº #{self.pago.numero}"
		@cc.conceptoNumero = self.numero
		@cc.save
	end

end
