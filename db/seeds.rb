# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

paises = Pais.create!([{nombre:'Argentina', abreviacion:'AR'}])

provincias = Provincia.create!([{pais_id: 1, codigoAfip: 0 , nombre: 'Capital Federal', nombre_corto: 'CF'},
	{pais_id: 1, codigoAfip: 1, nombre: 'Buenos Aires', nombre_corto: 'BA'},
	{pais_id: 1, codigoAfip: 2, nombre: 'Catamarca' , nombre_corto: 'CA' },
	{pais_id: 1, codigoAfip: 3, nombre: 'Cordoba', nombre_corto: 'CO' },
	{pais_id: 1, codigoAfip: 4, nombre: 'Corrientes', nombre_corto: 'COR'},
	{pais_id: 1, codigoAfip: 5, nombre: 'Entre Rios', nombre_corto: 'ER' },
	{pais_id: 1, codigoAfip: 6, nombre: 'Jujuy', nombre_corto: 'JY'},
	{pais_id: 1, codigoAfip: 7, nombre: 'Mendoza', nombre_corto: 'MZ'},
	{pais_id: 1, codigoAfip: 8, nombre: 'La Rioja', nombre_corto: 'LR'},
	{pais_id: 1, codigoAfip: 9, nombre: 'Salta', nombre_corto: 'SA'},
	{pais_id: 1, codigoAfip: 10, nombre: 'San Juan', nombre_corto: 'SJ'},
	{pais_id: 1, codigoAfip: 11, nombre: 'San Luis', nombre_corto: 'SL'},
	{pais_id: 1, codigoAfip: 12, nombre: 'Santa Fe', nombre_corto:'SF' },
	{pais_id: 1, codigoAfip: 13, nombre: 'Santiago del Estero', nombre_corto:'SE' },
	{pais_id: 1, codigoAfip: 14, nombre: 'Tucuman', nombre_corto: 'TU'},
	{pais_id: 1, codigoAfip: 15, nombre: 'Chaco', nombre_corto: 'CH'},
	{pais_id: 1, codigoAfip: 16, nombre: 'Chubut', nombre_corto: 'CHU'},
	{pais_id: 1, codigoAfip: 17, nombre: 'Formosa', nombre_corto: 'FOR'},
	{pais_id: 1, codigoAfip: 18, nombre: 'Misiones', nombre_corto: 'MI'},
	{pais_id: 1, codigoAfip: 19, nombre: 'Neuquen', nombre_corto: 'NEU'},
	{pais_id: 1, codigoAfip: 20, nombre: 'La Pampa', nombre_corto: 'LP'},
	{pais_id: 1, codigoAfip: 21, nombre: 'Rio Negro', nombre_corto: 'RN'},
	{pais_id: 1, codigoAfip: 22, nombre: 'Santa Cruz', nombre_corto: 'SC'},
	{pais_id: 1, codigoAfip: 23, nombre: 'Tierra del fuego', nombre_corto: 'TF'}])

usuario = User.create!([{email:"admin", password: "admin", profile_id: "3"}])