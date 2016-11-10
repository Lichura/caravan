class Cheque < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :pago, optional: true
	after_update :actualizar_cuenta_corriente
	after_create :impactar_cuenta_corriente
	after_create :estado_inicial

	validates :fecha, presence: true
	validates :banco, presence: true
	validates :numero, presence: true

	def estado_inicial
		self.recibido = true
		self.save
	end

	def actualizar_cuenta_corriente
		if self.rechazado_changed?
			if self.rechazado_was == false && self.rechazado == true
				distribuidor = User.find(self.pago.distribuidor_id)
			    @cc = CuentaCorriente.new
			    @cc.user_id = distribuidor.id
			    @cc.monto =  self.monto
			    @cc.concepto = "Se rechazo el cheque Nº #{self.numero}"
			    @cc.conceptoNumero = self.numero
			    @cc.save
			elsif self.rechazado_was == true && self.rechazado == false
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


		  def self.filtrar(cheque)
		    where("? = true", "#{cheque}")
		  end

	def self.search(cheque)
		distribuidores = User.where('"users"."razonSocial" LIKE ?', "%#{cheque}%").pluck(:id)
		pagos = Pago.where(distribuidor_id: distribuidores).pluck(:id)
		if cheque != "" && cheque.to_i > 0
			cheque = cheque.to_f
			where("(numero LIKE ? OR monto LIKE ?)", "%#{cheque}%", "%#{cheque}%")
		else
			where(pago_id: pagos)
		end

	end	  
end
