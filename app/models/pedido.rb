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
  after_create :reservar_stock_insumo
  before_destroy :devolver_stock_insumo
  before_create :calcularPrecioTotal
  #after_update :actualizar_stock_insumo
  #after_initialize :aumentar_numerador


  #deprecado por incorporacion de insumos..
  def devolver_stock
    self.detalles.each do |detalle|
      producto = Producto.find(detalle.producto_id)
      producto.stock_disponible += detalle.cantidad
      producto.stock_reservado -= detalle.cantidad
      producto.save
    end
  end

  #con esto calculo el precio segun los insumos seleccionados para cada articulo.
  def calcularPrecioTotal
    precio = 0
    cantidad = 0
    self.detalles.each do |detalle|
      if Producto.find(detalle.producto_id).tipo == 1
        precio_insumo = 0
        detalle.detalle_insumos.each do |insumos|
          insumo = Insumo.find(insumos.insumo_id)
          precio_insumo += insumo.precio
        end
        puts("el precio de los insumos suma #{precio_insumo}")
        precio += precio_insumo * detalle.cantidad
        detalle.precio = precio_insumo
        detalle.save
      else
        precio += Producto.find(detalle.producto_id).precio * detalle.cantidad 
      end
      cantidad += detalle.cantidad
    end
    self.precioTotal = precio
  end

  def reservar_stock_insumo
    self.detalles.each do |detalle|
      if Producto.find(detalle.producto_id).tipo == 1
        detalle.detalle_insumos.each do |detalle_insumo|
          producto = Producto.find(detalle_insumo.producto_id)
          insumo = Insumo.find(detalle_insumo.insumo_id)
          coeficiente = ProductoInsumo.find_by(producto_id: producto.id, insumo_id: insumo.id).coeficiente
            insumo.stock_disponible -= detalle.cantidad * coeficiente
            insumo.stock_reservado += detalle.cantidad * coeficiente
            insumo.save
        end
      else
        producto = Producto.find(detalle.producto_id)
        producto.stock_disponible -= detalle.cantidad
        producto.stock_reservado += detalle.cantidad
        producto.save
      end
    end
  end

  def devolver_stock_insumo
    self.detalles.each do |detalle|
      if Producto.find(detalle.producto_id).tipo == 1
        detalle.detalle_insumos.each do |detalle_insumo|
          producto = Producto.find(detalle_insumo.producto_id)
          insumo = Insumo.find(detalle_insumo.insumo_id)
          coeficiente = ProductoInsumo.find_by(producto_id: producto.id, insumo_id: insumo.id).coeficiente
            insumo.stock_disponible += detalle.cantidad_was * coeficiente
            insumo.stock_reservado -= detalle.cantidad_was * coeficiente
            insumo.save
        end
      else
        producto = Producto.find(detalle.producto_id)
        producto.stock_disponible += detalle.cantidad
        producto.stock_reservado -= detalle.cantidad
        producto.save
      end
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

