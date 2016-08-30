class User < ApplicationRecord

	#after_initialize :set_defaults, unless: :persisted?
	#belongs_to :profile
	has_many :user_sucursals
	accepts_nested_attributes_for :user_sucursals, allow_destroy: true
	#attr_accessor :password
	#before_save :encrypt_password
	before_create { generate_token(:auth_token) }
	has_secure_password

	#validates_confirmation_of :password
	#validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	#validates :condicionPago, presence: false
	include HTTParty
	

	def set_defaults
		self.profile_id = Profile.first[:id]
	end
	def self.search(usuario)
		where("name LIKE ? OR lastname LIKE ? OR email LIKE ?", "%#{usuario}%", "%#{usuario}%", "%#{usuario}%")
	end

	def self.authenticate(email, password)
		user = find_by_email(email)  #.first aca habia un 
		if user && user.password_hash = BCrypt::Engine.hash_secret(password, user.password_digest)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end	

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end


	def self.search_afip(cuit)
	
	#xml de la afip
		if cuit
			base_uri 'https://soa.afip.gob.ar/sr-padron/v2/persona/'+cuit
			format :json

			#voy a la ruta de xml y le indico que tiene que traerme todos los items de las noticias
			#def self.datos_cliente_afip()
			response = HTTParty.get(base_uri)
			response.parsed_response
		end
	end

end
