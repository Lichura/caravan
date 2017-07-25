class ProductoHistoricoSerializer < ActiveModel::Serializer
 attributes  :name, :data


 def name
 	data = object.producto_id
 end
 def data
 	data = {object.created_at => object.precio}
  end


   private

    def serialized_some_models some_models
      some_models.map{ |some_model| SomeModelSerializer.new(some_model, root: false) }
    end
end
