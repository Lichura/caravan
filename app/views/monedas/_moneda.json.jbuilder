json.extract! moneda, :id, :nombre, :descripcion, :simbolo, :tipoDeCambio, :created_at, :updated_at
json.url moneda_url(moneda, format: :json)