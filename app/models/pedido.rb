class Pedido < ApplicationRecord
  include ActiveModel::Dirty
	has_many :productos, :through => :detalles
	has_many :detalles
  has_many :remitos

    enum status: {
    activo: 0,
    confirmado_parcial: 1,
    confirmado: 2,
    remitido: 3,
    remitido_parcial: 4,
    facturado: 5,
    facturado_parcial: 6
    }
	accepts_nested_attributes_for :detalles,  allow_destroy: true
  
  before_validation :marcar_productos_para_destruir
  after_create :crear_pedido

  #after_initialize :aumentar_numerador

  private

  def marcar_productos_para_destruir
    detalles.each do |producto|
      if producto.cantidad.blank? or (producto.cantidad == 0)
        producto.mark_for_destruction
      end
    end
  end

  def crear_pedido
    self.activo!
  end


	def self.search(pedido)
		where("cuit LIKE ? OR comprobanteNumero LIKE ?", "%#{pedido}%", "%#{pedido}%")
	end



end

