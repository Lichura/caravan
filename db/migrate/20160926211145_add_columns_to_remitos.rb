class AddColumnsToRemitos < ActiveRecord::Migration[5.0]
  def change
    add_column :remitos, :empresa, :string
    add_column :remitos, :dniRetira, :integer
    add_column :remitos, :telefono, :string
    add_column :remitos, :numeroGuia, :string
    add_column :remitos, :destino, :string
    add_column :remitos, :retira, :string
    add_column :remitos, :comentarios, :string
  end
end
