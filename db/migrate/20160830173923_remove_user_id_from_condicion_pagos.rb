class RemoveUserIdFromCondicionPagos < ActiveRecord::Migration[5.0]
  def change
    remove_column :condicion_pagos, :user_id, :integer
    add_column :users, :condicion_id, :integer
  end
end
