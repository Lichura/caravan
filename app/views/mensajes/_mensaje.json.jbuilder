json.extract! mensaje, :id, :nombre, :empresa, :email, :telefono, :texto, :created_at, :updated_at
json.url mensaje_url(mensaje, format: :json)