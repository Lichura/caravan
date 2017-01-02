class PaginaPrincipal < ApplicationRecord
	has_many :pagina_principal_productos, :inverse_of => :pagina_principal
	accepts_nested_attributes_for :pagina_principal_productos, allow_destroy: true

end
