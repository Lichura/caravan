json.extract! pais, :id, :nombre, :abreviacion, :created_at, :updated_at
json.url pais_url(pais, format: :json)