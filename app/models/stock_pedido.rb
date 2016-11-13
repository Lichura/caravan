class StockPedido < ApplicationRecord
  has_many :insumos, :through => :stock_items
  has_many :stock_items , dependent: :destroy
  accepts_nested_attributes_for :stock_items,  allow_destroy: true

 before_validation :marcar_productos_para_destruir

  def marcar_productos_para_destruir
    stock_items.each do |producto|
      if producto.cantidad.blank? or (producto.cantidad == 0)
        producto.mark_for_destruction
      end
    end
  end
end
