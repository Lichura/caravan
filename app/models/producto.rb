class Producto < ApplicationRecord
  belongs_to :familium
  has_many :pedidos, :through => :detalles
  has_many :detalles
  has_many :remito_items
  has_many :remitos, :through => :remito_items
  has_many :facturas, :through => :factura_items
  has_many :factura_items
  mount_uploader :imagen, ImagenUploader

  before_save :agregar_a_historico

  private
  def self.search(producto)
		where("nombre LIKE ? OR descripcion LIKE ?", "%#{producto}%", "%#{producto}%")
	end

  def agregar_a_historico

    @historico = ProductoHistorico.create!([{producto_id: self.id, precio: self.precio, fechaDesde: self.updated_at, fechaHasta: DateTime.now}])
  end
end
