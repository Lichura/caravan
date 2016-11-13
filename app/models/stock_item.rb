class StockItem < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :stock_pedido, optional: true
  belongs_to :insumo, optional: true

  after_update :chequear_recibido
  after_destroy :eliminar_pedido
  after_create :nuevo_pedido

  private

  def nuevo_pedido
  	@insumo = Insumo.find(self.insumo_id)
  	@insumo.stock_pedido += self.cantidad
  	@insumo.save
  end

  def chequear_recibido
  	if self.recibido_changed?
  		unless self.recibido
  			@insumo = Insumo.find(self.insumo_id)
  			@insumo.stock_pedido += self.cantidad
  			@insumo.stock_disponible -= self.cantidad
  			@insumo.stock_fisico -= self.cantidad
  			@insumo.save
  		else
  			@insumo = Insumo.find(self.insumo_id)
  			@insumo.stock_pedido -= self.cantidad
  			@insumo.stock_disponible += self.cantidad
  			@insumo.stock_fisico += self.cantidad
  			@insumo.save
  		end
  	end	
  end

  def eliminar_pedido
  	if self.recibido
  		@insumo = Insumo.find(self.insumo_id)
  		@insumo.stock_disponible -= self.cantidad
  		@insumo.stock_fisico -= self.cantidad
  		@insumo.save
  	else
  	  	@insumo = Insumo.find(self.insunmo_id)
  		@insumo.stock_pedido -= self.cantidad
  		@insumo.save
  	end		
  end
end
