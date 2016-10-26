class Cheque < ApplicationRecord

	belongs_to :pago, optional: true
end
