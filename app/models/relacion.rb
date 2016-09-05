class Relacion < ApplicationRecord
  belongs_to :user
  belongs_to :cliente, :class_name => 'User'
end
