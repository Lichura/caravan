class Pedido < ApplicationRecord
  include ActiveModel::Dirty
	has_many :productos, :through => :detalles
	has_many :detalles
  has_many :remitos

  validates :cuit, presence: true

    enum status: {
    activo: 0,
    confirmado_parcial: 1,
    confirmado: 2,
    remitido: 3,
    remitido_parcial: 4,
    finalizado_por_ajuste: 5,
    facturado: 6,
    facturado_parcial: 7
    }
	accepts_nested_attributes_for :detalles,  allow_destroy: true
  
  before_validation :marcar_productos_para_destruir
  after_create :generar_boolean
  #after_initialize :aumentar_numerador

  def devolver_stock
    self.detalles.each do |detalle|
      producto = Producto.find(detalle.producto_id)
      producto.stock_disponible += detalle.cantidad
      producto.stock_reservado -= detalle.cantidad
      producto.save
    end
  end

  private

  def generar_boolean 
    self.remitido = false
    self.facturado = false
    self.save
  end

  def marcar_productos_para_destruir
    detalles.each do |producto|
      if producto.cantidad.blank? or (producto.cantidad == 0)
        producto.mark_for_destruction
      end
    end
  end


	def self.search(pedido)
		where("cuit LIKE ? OR comprobanteNumero LIKE ?", "%#{pedido}%", "%#{pedido}%")
	end

  def self.filtrar(pedido)
    where("status = ?", "#{pedido}")
  end



end

