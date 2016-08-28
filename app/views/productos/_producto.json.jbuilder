json.extract! producto, :id, :nombre, :descripcion,  :precio, :activo, :familia_id, :created_at, :updated_at
json.url producto_url(producto, format: :json)