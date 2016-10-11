class NotaCreditoSerializer < ActiveModel::Serializer
  attributes :id, :cliente_id, :factura_id, :distribuidor_id, :vendedor_id, :fecha, :estado, :tipo, :neto, :iva, :total
end
