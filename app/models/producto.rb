class Producto < ApplicationRecord
  belongs_to :familium
  has_many :pedidos, :through => :detalles
  has_many :detalles
  has_many :remito_items
  has_many :remitos, :through => :remito_items
  has_many :facturas, :through => :factura_items
  has_many :factura_items
  has_many :nota_creditos, :through => :nota_credito_items
  has_many :nota_credito_items
  has_many :producto_insumos
  has_many :insumos, :through => :producto_insumos
  has_many :detalles, :through => :detalle_insumos
  has_many :detalle_insumos
  has_many :stock_pedidos, :through => :stock_items
  has_many :stock_items , dependent: :destroy


  mount_uploader :imagen, ImagenUploader

  after_update :agregar_a_historico
  before_validation :destruir_insumos_si_no_necesita
  before_destroy :chequear_uso_antes_de_eliminar
  #before_validation :marcar_productos_para_destruir

  after_destroy { |record|
            ProductoInsumo.destroy(record.producto_insumos.pluck(:id))
          }

  accepts_nested_attributes_for :producto_insumos,  allow_destroy: true

  def prueba(producto)
    producto.producto_insumos do |insumos|
      insumo = Insumo.find(insumo.insumo_id)
      producto.stock_disponible = insumo.stock_disponible / insumos.coeficiente
    end
    producto.save
  end

  def chequear_uso_antes_de_eliminar
    if Detalle.any? {|detalle| detalle.producto_id == self.id}
      errors.add(:id, 'Se encuentra en uso.')
      false
    else
      true
    end
  end

def marcar_productos_para_destruir
    self.producto_insumos.each do |insumo|
      if insumo.coeficiente.blank? or (insumo.coeficiente == 0)
        insumo.mark_for_destruction
      end
    end
  end

  def destruir_insumos_si_no_necesita
    if self.tipo == 2 or self.tipo == 3
      self.producto_insumos.each do |insumo|
        insumo.mark_for_destruction
      end
    end
  end
  
  TIPOS = {1 => "Producto", 2 => "Producto sin insumos", 3 => "Concepto"}
  private
  def self.search(producto)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{producto}%", "%#{producto}%")
	end

  def agregar_a_historico
    if self.precio_changed?
      @historico = ProductoHistorico.create!([{producto_id: self.id, precio: self.precio, fechaDesde: self.updated_at, fechaHasta: DateTime.now}])
    end
  end


    def destruir_relacion_con_insumos
     self.producto_insumos.delete_all   
   end
end
