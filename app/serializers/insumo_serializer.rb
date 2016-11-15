class InsumoSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :descripcion, :precio, :unidad_medida, :stock_fisico, :stock_reservado, :stock_disponible, :stock_pedido
end
