json.extract! detalle, :id, :pedido_id, :producto_id, :cantidad, :precio, :created_at, :updated_at
json.url detalle_url(detalle, format: :json)