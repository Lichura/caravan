json.extract! condicion_pago, :id, :user_id, :nombre, :descripcion, :dias, :created_at, :updated_at
json.url condicion_pago_url(condicion_pago, format: :json)