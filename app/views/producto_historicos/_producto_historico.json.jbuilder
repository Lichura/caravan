json.extract! producto_historico, :id, :producto_id, :precio, :fechaDesde, :fechaHasta, :created_at, :updated_at
json.url producto_historico_url(producto_historico, format: :json)