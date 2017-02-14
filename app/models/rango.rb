class Rango < ApplicationRecord
	belongs_to :user
	belongs_to :pedido


	def self.to_csv(options = {})
    	CSV.generate(options) do |csv|
      		csv << column_names
      		all.each do |product|
        		csv << rango.attributes.values_at(*column_names)
      		end
    	end
  	end
end
