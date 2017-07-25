class PaginaPrincipalProducto < ApplicationRecord

	belongs_to :pagina_principal, :inverse_of => :pagina_principal_productos
	mount_uploader :imagen, ImagenUploader
end
