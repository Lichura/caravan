class Factura < ApplicationRecord
	has_and_belongs_to_many :remitos, optional: true
	has_many :factura_items
	has_many :productos, :through => :factura_items

	accepts_nested_attributes_for :factura_items,  allow_destroy: true

	after_initialize :aumentar_numerador
	before_validation :marcar_productos_para_destruir
	after_create :nueva_factura_cuenta_corriente
  	after_destroy :eliminar_factura_cuenta_corriente
  	after_create :actualizar_estado_pedido

	private
	def aumentar_numerador
		if Factura.maximum(:numero)
			self.numero = Factura.maximum(:numero) + 1
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

  	 def nueva_factura_cuenta_corriente
	    @cc = CuentaCorriente.new
	    @cc.user_id = User.find_by(cuit: self.cuit).id
	    @cc.monto = self.total
	    @cc.concepto = "Se creo la Factura Nº #{self.numero}"
	    @cc.conceptoNumero = self.numero
	    @cc.save
 	 end

	  def eliminar_factura_cuenta_corriente
	    @cc = CuentaCorriente.new
	    @cc.user_id = User.find_by(cuit: self.cuit).id
	    @cc.monto = -1 * (self.total)
	    @cc.concepto = "Se anulo la factura Nº #{self.numero}"
	    @cc.conceptoNumero = self.numero
	    @cc.save
	  end


	  def actualizar_estado_pedido
      	self.remitos.each do |remito|
        if remito.pedido.remitos.all? {|remito| remito.facturado?}
          remito.pedido.facturado!
          remito.pedido.facturado = true
        elsif remito.pedido.remitos.any? {|remito| remito.facturado? || remito.estado == "Pendiente" || remito.estado == "Facturado parcial"}
          remito.pedido.facturado_parcial!
        else
          remito.pedido.remitido!
        end
        remito.pedido.save
      end
    end
end
