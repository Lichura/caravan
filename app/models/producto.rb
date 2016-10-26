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
  mount_uploader :imagen, ImagenUploader

  after_update :agregar_a_historico
  TIPOS = {1 => "Producto", 2 => "Concepto"}
  private
  def self.search(producto)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{producto}%", "%#{producto}%")
	end

  def agregar_a_historico
    if self.precio_changed?
      @historico = ProductoHistorico.create!([{producto_id: self.id, precio: self.precio, fechaDesde: self.updated_at, fechaHasta: DateTime.now}])
    end
  end
end
