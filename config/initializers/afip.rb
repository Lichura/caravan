require 'bravo'

Bravo.pkey                           = 'config/certs/pkey.key'
Bravo.cert                           = 'config/certs/cert.crt'
Bravo.cuit                           = '20335067623'
Bravo.sale_point                     = '0002'
Bravo.default_concepto               = 'Productos y Servicios'
Bravo.default_documento              = 'CUIT'
Bravo.default_moneda                 = :peso
Bravo.own_iva_cond                   = :responsable_inscripto
Bravo.verbose                        = 'true'
#Bravo.openssl_bin                    = '/usr/local/openssl-1.0.2h/bin'
#Bravo::AuthData.environment      	  = :test