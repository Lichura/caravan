class User < ApplicationRecord
  enum role: [:admin, :distribuidor, :cliente]
	#after_initialize :set_defaults, unless: :persisted?
	#belongs_to :profile

	has_many :user_sucursals, :inverse_of => :user
	accepts_nested_attributes_for :user_sucursals, allow_destroy: true
	belongs_to :profile
	#attr_accessor :password
	#before_save :encrypt_password
  	#has_many :clientes, class_name: "User", foreign_key: "distribuidor_id", inverse_of: :distribuidor
  	#belongs_to :distribuidor, class_name: "User", inverse_of: :clientes

  	has_many :relacions
  	has_many :clientes, :through => :relacions

	before_create { generate_token(:auth_token) }
	has_secure_password

	#validates_confirmation_of :password
	#validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	#validates :condicionPago, presence: false
	validates :password, :presence     => false
	validates :password_confirmation, :presence     => false
	validates :telefono, format: { with: /([0-9]{5,15})/, message: "El telefono que ingreso no es correcto" }, :allow_blank => true
	validates :celular, format: { with: /([0-9]{5,15})/, message: "El celular que ingreso no es correcto" }, :allow_blank => true


	include HTTParty


	  before_save :condicion_de_pago


	def afip
	  @afip ||= afip.present? ? "#{user.nombre.capitalize}" : "No user" # or Anonymous(whichever suites your requirement)
	end
  	def condicion_de_pago
    	self.condicion_id = 1
  	end

	def set_password
		if self.profile_id == 2

		end
	end
	def set_defaults
		self.profile_id = Profile.first[:id]
	end
	def self.search(usuario)
		where("CUIT LIKE ? OR razonSocial LIKE ? OR email LIKE ?", "%#{usuario}%", "%#{usuario}%", "%#{usuario}%")
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
