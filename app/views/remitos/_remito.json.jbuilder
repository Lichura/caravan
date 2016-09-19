json.extract! remito, :id, :pedido_id, :numero, :fecha, :transporte, :ivaTotal, :total, :cantidadTotal, :created_at, :updated_at
json.url remito_url(remito, format: :json)