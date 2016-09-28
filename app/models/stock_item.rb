class StockItem < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :stock_pedido, optional: true
  belongs_to :producto, optional: true

  after_update :chequear_recibido
  after_destroy :eliminar_pedido
  after_create :nuevo_pedido

  private

  def nuevo_pedido
  	@producto = Producto.find(self.producto_id)
  	@producto.stock_pedido += self.cantidad
  	@producto.save
  end

  def chequear_recibido
  	if self.recibido_changed?
  		unless self.recibido
  			@producto = Producto.find(self.producto_id)
  			@producto.stock_pedido += self.cantidad
  			@producto.stock_disponible -= self.cantidad
  			@producto.stock_fisico -= self.cantidad
  			@producto.save
  		else
  			@producto = Producto.find(self.producto_id)
  			@producto.stock_pedido -= self.cantidad
  			@producto.stock_disponible += self.cantidad
  			@producto.stock_fisico += self.cantidad
  			@producto.save
  		end
  	end	
  end

  def eliminar_pedido
  	if self.recibido
  		@producto = Producto.find(self.producto_id)
  		@producto.stock_disponible -= self.cantidad
  		@producto.stock_fisico -= self.cantidad
  		@producto.save
  	else
  	  	@producto = Producto.find(self.producto_id)
  		@producto.stock_pedido -= self.cantidad
  		@producto.save
  	end		
  end
end
