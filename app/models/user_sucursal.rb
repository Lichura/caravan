class UserSucursal < ApplicationRecord
	belongs_to :user, :inverse_of => :user_sucursals

	validates :nombre, presence: true
end
