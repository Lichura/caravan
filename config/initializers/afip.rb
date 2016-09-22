require 'rubygems'
gem 'soap4r'
require File.join(Rails.root, "lib", "wsafip", "wsaa_driver.rb")
require File.join(Rails.root, "lib", "wsafip", "wsaa_request.rb")
require File.join(Rails.root, "lib", "wsafip", "wsaa_service.rb")


ticket = WSAA::WSAAService.request_ticket( :service => 'wsaa',
	                                           :certificate => 'config/certs/cert.crt',
	                                           :private_key => 'config/certs/pkey.key')