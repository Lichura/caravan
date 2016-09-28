class ProductoHistorico < ApplicationRecord

  def self.hashify
    @productos = ProductoHistorico.group(:producto_id).to_a
    @productos_hash = @productos.inject({}) do |result, element|
      result = {:name => element[:producto_id], :data => {element.each do |k,v| {k[created_at] => k[precio]}}
      result
    end
  end

end
