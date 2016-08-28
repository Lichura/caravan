require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Caravanas
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end




require 'bravo'

Bravo.pkey                           = 'config/pkey'
Bravo.cert                           = 'config/cert.crt'
Bravo.cuit                           = '20335067623'
Bravo.sale_point                     = '0001'
Bravo.default_concepto               = 'Productos y Servicios'
Bravo.default_documento              = 'CUIT'
Bravo.default_moneda                 = :peso
Bravo.own_iva_cond                   = :responsable_inscripto
Bravo.verbose                        = 'true'
#Bravo.openssl_bin                    = '/usr/local/Cellar/openssl/1.0.2h_1/bin/openssl'
#Bravo::AuthData.environment      = :test