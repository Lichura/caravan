json.array!(@pedidos) do |pedido|
  json.extract! pedido, :id, :cuit
  json.url pedido_url(pedido, format: :json)
end