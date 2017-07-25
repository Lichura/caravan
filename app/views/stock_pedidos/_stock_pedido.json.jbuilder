json.extract! stock_pedido, :id, :vendedor, :cantidadTotal, :precioTotal, :created_at, :updated_at
json.url stock_pedido_url(stock_pedido, format: :json)