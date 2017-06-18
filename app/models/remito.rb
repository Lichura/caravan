class Remito < ApplicationRecord
	include ActiveModel::Dirty

	has_many :remito_items
	has_many :productos, :through => :remito_items
	belongs_to :pedido, optional: true
	has_and_belongs_to_many :facturas, optional: true


	before_create :generar_numero_y_estado_pendiente_de_facturar

	after_save :modificar_estado_pedido, :if => :remito_tiene_pedido
	#before_validation :marcar_productos_para_destruir
	accepts_nested_attributes_for :remito_items,  allow_destroy: true
	validates :telefono, format: { with: /([0-9]{5,12})/, message: "El telefono ingresado no es correcto" }, :allow_blank => true
	validates :dniRetira, format: { with: /([0-9]{8,9})/, message: "El Dni ingresado no es correcto" }, :allow_blank => true


	private



 	def generar_numero_y_estado_pendiente_de_facturar
    	self.numero = Remito.maximum(:numero) + 1 || 1 unless self.numero
    	self.estado = "Pendiente de facturar"
		self.facturado = false
  	end

	#los productos que no tengan cantidad o su cantidad sea 0 se eliminan del remito.
	def marcar_productos_para_destruir
	    remito_items.each do |producto|
	      if producto.cantidad.blank? or (producto.cantidad == 0)
		        producto.mark_for_destruction
		   end
		end
	end

	def remito_tiene_pedido
		return true unless self.pedido.nil? 
	end

	#cambio el estado del pedido una vez que se hayan remitido todos los articulos
	def modificar_estado_pedido
		@@pedido = Pedido.find(self.pedido_id) 
		if @@pedido.detalles.all? {|producto| producto.pendiente_remitir == 0}
		    @@pedido.remitido!
		elsif @@pedido.detalles.any? {|producto| producto.pendiente_remitir == 0}
		   	@@pedido.remitido_parcial!
		elsif self.finalizado
			@@pedido.finalizado_por_ajuste!
		end
		@@pedido.save
	end

	def self.search(remito)
		usuario = "" || User.where("CUIT LIKE ? OR razonSocial LIKE ?", "%#{remito}%", "%#{remito}%").first.id 
		where("pedido_id LIKE ? OR numero LIKE ?", "%#{remito}%", "%#{remito}%")
	end



#deberia pasar estos dos metodos al modelo de remito_items
  def modificar_stock
    @pedido = Pedido.find(@remito.pedido_id)
    @pedido.detalles.each do |producto|
      @remito.remito_items.each do |item|
        if producto.producto_id == item.producto_id && !item.cantidad.blank?
          producto.pendiente_remitir -= item.cantidad
        end
      end
    end
    @pedido.save
  end



  def modificar_stock_destruir
    if @remito.pedido_id
    @pedido = Pedido.find(@remito.pedido_id)
    @pedido.detalles.each do |producto|
      @remito.remito_items.each do |item|
        if producto.producto_id == item.producto_id && !item.cantidad.blank?
          producto.pendiente_remitir += item.cantidad
        end
      end
    end
    @pedido.save
  end
  end





end
