class PagoSerializer < ActiveModel::Serializer
  attributes :id, :distribuidor_id, :numero, :medioDePago, :monto, :estado
end
