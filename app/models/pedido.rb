class Pedido < ApplicationRecord
  include ActiveModel::Dirty
	has_many :productos, :through => :detalles
	has_many :detalles
  has_many :remitos
  has_many :remito_items, :through => :remitos
  has_many :rangos



  validates :cuit, presence: true
  #validates_with GoodnessValidator, fields: [:detalles[:last_name]]

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
  #after_create :reservar_stock_insumo
  #before_destroy :devolver_stock_insumo
  after_create :calcularPrecioTotal
  after_create :calcular_rango_automatico
  #after_update :actualizar_stock_insumo
  #after_initialize :aumentar_numerador


  after_destroy { |record|
              Detalle.destroy(record.detalles.pluck(:id))
            }

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
    distribuidor = User.find(self.distribuidor_id)
    if distribuidor.descuento?
      descuento = 1.0 - (distribuidor.descuento / 100.0)
    else
      descuento = 1.0
    end
    puts("================= descuentooooooo #{descuento}")
    self.detalles.each do |detalle|
      if Producto.find(detalle.producto_id).tipo == 1
        precio_insumo = 0
        detalle.detalle_insumos.each do |insumos|
          insumo = Insumo.find(insumos.insumo_id)
          coeficiente = ProductoInsumo.find_by(producto_id: detalle.producto_id, insumo_id: insumo.id).coeficiente
          precio_insumo += insumo.precio * coeficiente 
        end
        puts("el precio de los insumos suma #{precio_insumo}")
        precio += precio_insumo * detalle.cantidad 
        detalle.precio = precio_insumo * descuento
        detalle.save
      else
        precio += Producto.find(detalle.producto_id).precio * detalle.cantidad 
      end
      cantidad += detalle.cantidad
    end
      self.precioTotal = precio * descuento
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
        if !producto.stock_disponible.nil?
        producto.stock_disponible -= detalle.cantidad
        producto.stock_reservado += detalle.cantidad
        else
          producto.stock_disponible = 0 - detalle.cantidad
          producto.stock_reservado =  detalle.cantidad
        end
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



  def calcular_rango_automatico
      self.detalles.each do |detalle|
        producto =  Producto.find(detalle.producto_id)
        usuario = self.user_id
        if producto.correlativo?
          if rango = UserRango.where(user_id: usuario, producto_id: producto.id).first
            detalle.rango_desde = rango.rango + 1
            detalle.rango_hasta = rango.rango + detalle.cantidad
            rango.rango += detalle.cantidad
            rango.save 
          else
            detalle.rango_desde = 1
            detalle.rango_hasta = detalle.cantidad
            rango_nuevo = UserRango.new
              rango_nuevo.user_id = usuario
              rango_nuevo.producto_id = producto.id
              rango_nuevo.rango = detalle.cantidad
            rango_nuevo.save
          end
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




class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any?{|field| record.send(field) == "Evil" }
      record.errors[:base] << "This person is evil"
    end
  end
end
