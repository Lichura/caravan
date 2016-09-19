class StockItem < ApplicationRecord
  belongs_to :stock_pedido, optional: true
  belongs_to :producto, optional: true
end
