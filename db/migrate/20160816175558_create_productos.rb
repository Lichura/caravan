class CreateProductos < ActiveRecord::Migration[5.0]
  def change
    create_table :productos do |t|
      t.string :nombre
      t.string :descripcion
      t.float :precio
      t.boolean :activo
      t.belongs_to :familia, foreign_key: true

      t.timestamps
    end
  end
end
