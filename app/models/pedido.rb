class Pedido < ApplicationRecord
	has_many :productos, :through => :detalles
	has_many :detalles
  has_many :remitos

	accepts_nested_attributes_for :detalles,  allow_destroy: true


  before_validation :marcar_productos_para_destruir
  #after_initialize :aumentar_numerador

  private


  def aumentar_numerador
   
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
end

