class RangoSerializer < ActiveModel::Serializer
  attributes :id, :letras, :numero, :digito, :pedido_id, :user_id
end
