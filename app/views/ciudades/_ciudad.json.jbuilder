json.extract! ciudad, :id, :pais_id, :provincia_id, :nombre, :nombre_corto, :created_at, :updated_at
json.url ciudad_url(ciudad, format: :json)