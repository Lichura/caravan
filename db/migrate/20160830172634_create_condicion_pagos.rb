class CreateCondicionPagos < ActiveRecord::Migration[5.0]
  def change
    create_table :condicion_pagos do |t|
      t.integer :user_id
      t.string :nombre
      t.string :descripcion
      t.integer :dias

      t.timestamps
    end
  end
end
