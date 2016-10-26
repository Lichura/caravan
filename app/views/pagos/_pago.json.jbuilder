json.extract! pago, :id, :distribuidor_id, :numero, :medioDePago, :monto, :estado, :created_at, :updated_at
json.url pago_url(pago, format: :json)