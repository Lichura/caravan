class StockItem < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :stock_pedido, optional: true
  belongs_to :insumo, optional: true
  belongs_to :producto, optional: true

  after_update :chequear_recibido
  after_destroy :eliminar_pedido
  after_create :nuevo_pedido

  private

  def nuevo_pedido
    if self.insumo_id?
  	 @insumo = Insumo.find(self.insumo_id)
     @insumo.stock_pedido ||= 0
  	 @insumo.stock_pedido += self.cantidad
  	 @insumo.save
    else
      @producto = Producto.find(self.producto_id)
      @producto.stock_pedido ||= 0
      @producto.stock_pedido += self.cantidad 
      @producto.save
    end
  end

  def chequear_recibido
  	if self.recibido_changed?
      if self.insumo_id?
        @insumo = Insumo.find(self.insumo_id)
        @insumo.stock_pedido ||= 0
        @insumo.stock_disponible ||= 0
        @insumo.stock_fisico ||= 0
    		unless self.recibido
    			@insumo.stock_pedido += self.cantidad
    			@insumo.stock_disponible -= self.cantidad
    			@insumo.stock_fisico -= self.cantidad
    		else
    			@insumo.stock_pedido -= self.cantidad
    			@insumo.stock_disponible += self.cantidad
    			@insumo.stock_fisico += self.cantidad
    		end
        @insumo.save
      else
        @producto = Producto.find(self.producto_id)
        @producto.stock_pedido ||= 0
        @producto.stock_disponible ||= 0
        @producto.stock_fisico ||= 0
        unless self.recibido
          @producto.stock_pedido += self.cantidad
          @producto.stock_disponible -= self.cantidad
          @producto.stock_fisico -= self.cantidad
        else
          @producto.stock_pedido -= self.cantidad
          @producto.stock_disponible += self.cantidad
          @producto.stock_fisico += self.cantidad
        end
        @producto.save
      end
  	end	
  end

  def eliminar_pedido
    if self.insumo_id?
      @insumo = Insumo.find(self.insumo_id)
    	 if self.recibido
      		@insumo.stock_disponible -= self.cantidad
      		@insumo.stock_fisico -= self.cantidad
      	else
      		@insumo.stock_pedido -= self.cantidad
      	end	
        @insumo.save	
      else
        @producto = Producto.find(self.producto_id)
       if self.recibido
          @producto.stock_disponible -= self.cantidad
          @producto.stock_fisico -= self.cantidad
        else
          @producto.stock_pedido -= self.cantidad
        end 
        @producto.save  
      end
  end
end
