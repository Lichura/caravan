$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'bravo'


class SpecHelper
  include Savon::Logger
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Bravo.pkey = "config/certs/pkey"
Bravo.cert = "config/certs/cert.crt"
Bravo.cuit = '20335067623' || raise(Bravo::NullOrInvalidAttribute.new, "Please set CUIT env variable.")
Bravo.sale_point = "0002"
Bravo.service_url = "http://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL"
Bravo.default_concepto = "Productos y Servicios"
Bravo.default_documento = "CUIT"
Bravo.default_moneda = :peso
Bravo.own_iva_cond = :responsable_inscripto