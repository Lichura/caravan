class StockPedido < ApplicationRecord
  has_many :productos, :through => :stock_items
  has_many :stock_items
  accepts_nested_attributes_for :stock_items,  allow_destroy: true
end
