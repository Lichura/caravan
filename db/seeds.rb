# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pais.destroy_all
Provincia.destroy_all
Ciudad.destroy_all
Profile.destroy_all
User.destroy_all
Familia.destroy_all
Producto.destroy_all


familia = Familia.create!([{
	id:1, nombre: "Caravanas", nombre: "Caravanas" 
}])

productos = Producto.create!([
	{id:1, nombre: "Caravana 1", precio: 100, activo: true, familia_id: 1, stock_fisico: 0, stock_disponible: 0, stock_reservado: 0, stock_pedido: 0 },
	{id:2, nombre: "Caravana 2", precio: 50, activo: true, familia_id: 1, stock_fisico: 0, stock_disponible: 0, stock_reservado: 0, stock_pedido: 0},
	{id:3, nombre: "Caravana 3", precio: 250, activo: true, familia_id: 1, stock_fisico: 0, stock_disponible: 0, stock_reservado: 0, stock_pedido: 0}
])





perfiles = Profile.create!([
  {id: 1, nombre: "admin", descripcion: "admin"},
  {id: 2, nombre: "distribuidores", descripcion: "distribuidores"},
  {id: 3, nombre: "cliente", descripcion: "cliente"}])
  
  
usuarios = User.create!([{
    profile_id: 1,
    email:"lichun88@gmail.com",
    password: "admin",
    password_confirmation: "admin",
    razonSocial: "Licho",
    direccion: "bla bla",
    cuig: "321321312",
    renspa: "131232321",
    cuit: 20335067623,
    telefono: "144132312",
    codigoPostal: "08018",
    provincia_id: 1,
    pais_id: 1,
    encargado: "Licho",
    celular: "13123123",
    numeroCv: "23123"}
,
    {
    profile_id: 2,
    email:"distribuidor",
    password: "distribuidor",
    password_confirmation: "distribuidor",
    razonSocial: "Distribuidor 1",
    direccion: "bla bla",
    cuig: "321321312",
    renspa: "131232321",
    cuit: 20335067623,
    telefono: "144132312",
    codigoPostal: "08018",
    provincia_id: 1,
    pais_id: 1,
    numeroCv: "23123"
  }])
paises = Pais.create!([{id: 1, nombre:'Argentina', abreviacion:'AR'}])

provincias = Provincia.create!([{pais_id: 1, id:1, codigoAfip: 0 , nombre: 'Capital Federal', nombre_corto: 'CF'},
	{pais_id: 1, id:2, codigoAfip: 1, nombre: 'Buenos Aires', nombre_corto: 'BA'},
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



ciudades = Ciudad.create!([
	{pais_id:1,	provincia_id:2,	nombre:"25 de Mayo"},
{pais_id:1,	provincia_id:2,	nombre:"3 de febrero"},
{pais_id:1,	provincia_id:2,	nombre:"A. Alsina"},
{pais_id:1,	provincia_id:2,	nombre:"A. Gonzáles Cháves"},
{pais_id:1,	provincia_id:2,	nombre:"Aguas Verdes"},
{pais_id:1,	provincia_id:2,	nombre:"Alberti"},
{pais_id:1,	provincia_id:2,	nombre:"Arrecifes"},
{pais_id:1,	provincia_id:2,	nombre:"Ayacucho"},
{pais_id:1,	provincia_id:2,	nombre:"Azul"},
{pais_id:1,	provincia_id:2,	nombre:"Bahía Blanca"},
{pais_id:1,	provincia_id:2,	nombre:"Balcarce"},
{pais_id:1,	provincia_id:2,	nombre:"Baradero"},
{pais_id:1,	provincia_id:2,	nombre:"Benito Juárez"},
{pais_id:1,	provincia_id:2,	nombre:"Berisso"},
{pais_id:1,	provincia_id:2,	nombre:"Bolívar"},
{pais_id:1,	provincia_id:2,	nombre:"Bragado"},
{pais_id:1,	provincia_id:2,	nombre:"Brandsen"},
{pais_id:1,	provincia_id:2,	nombre:"Campana"},
{pais_id:1,	provincia_id:2,	nombre:"Cañuelas"},
{pais_id:1,	provincia_id:2,	nombre:"Capilla del Señor"},
{pais_id:1,	provincia_id:2,	nombre:"Capitán Sarmiento"},
{pais_id:1,	provincia_id:2,	nombre:"Carapachay"},
{pais_id:1,	provincia_id:2,	nombre:"Carhue"},
{pais_id:1,	provincia_id:2,	nombre:"Cariló"},
{pais_id:1,	provincia_id:2,	nombre:"Carlos Casares"},
{pais_id:1,	provincia_id:2,	nombre:"Carlos Tejedor"},
{pais_id:1,	provincia_id:2,	nombre:"Carmen de Areco"},
{pais_id:1,	provincia_id:2,	nombre:"Carmen de Patagones"},
{pais_id:1,	provincia_id:2,	nombre:"Castelli"},
{pais_id:1,	provincia_id:2,	nombre:"Chacabuco"},
{pais_id:1,	provincia_id:2,	nombre:"Chascomús"},
{pais_id:1,	provincia_id:2,	nombre:"Chivilcoy"},
{pais_id:1,	provincia_id:2,	nombre:"Colón"},
{pais_id:1,	provincia_id:2,	nombre:"Coronel Dorrego"},
{pais_id:1,	provincia_id:2,	nombre:"Coronel Pringles"},
{pais_id:1,	provincia_id:2,	nombre:"Coronel Rosales"},
{pais_id:1,	provincia_id:2,	nombre:"Coronel Suarez"},
{pais_id:1,	provincia_id:2,	nombre:"Costa Azul"},
{pais_id:1,	provincia_id:2,	nombre:"Costa Chica"},
{pais_id:1,	provincia_id:2,	nombre:"Costa del Este"},
{pais_id:1,	provincia_id:2,	nombre:"Costa Esmeralda"},
{pais_id:1,	provincia_id:2,	nombre:"Daireaux"},
{pais_id:1,	provincia_id:2,	nombre:"Darregueira"},
{pais_id:1,	provincia_id:2,	nombre:"Del Viso"},
{pais_id:1,	provincia_id:2,	nombre:"Dolores"},
{pais_id:1,	provincia_id:2,	nombre:"Don Torcuato"},
{pais_id:1,	provincia_id:2,	nombre:"Ensenada"},
{pais_id:1,	provincia_id:2,	nombre:"Escobar"},
{pais_id:1,	provincia_id:2,	nombre:"Exaltación de la Cruz"},
{pais_id:1,	provincia_id:2,	nombre:"Florentino Ameghino"},
{pais_id:1,	provincia_id:2,	nombre:"Garín"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Alvarado"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Alvear"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Arenales"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Belgrano"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Guido"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Lamadrid"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Las Heras"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Lavalle"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Madariaga"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Pacheco"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Paz"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Pinto"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Pueyrredón"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Rodríguez"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Viamonte"},
{pais_id:1,	provincia_id:2,	nombre:"Gral. Villegas"},
{pais_id:1,	provincia_id:2,	nombre:"Guaminí"},
{pais_id:1,	provincia_id:2,	nombre:"Guernica"},
{pais_id:1,	provincia_id:2,	nombre:"Hipólito Yrigoyen"},
{pais_id:1,	provincia_id:2,	nombre:"Ing. Maschwitz"},
{pais_id:1,	provincia_id:2,	nombre:"Junín"},
{pais_id:1,	provincia_id:2,	nombre:"La Plata"},
{pais_id:1,	provincia_id:2,	nombre:"Laprida"},
{pais_id:1,	provincia_id:2,	nombre:"Las Flores"},
{pais_id:1,	provincia_id:2,	nombre:"Las Toninas"},
{pais_id:1,	provincia_id:2,	nombre:"Leandro N. Alem"},
{pais_id:1,	provincia_id:2,	nombre:"Lincoln"},
{pais_id:1,	provincia_id:2,	nombre:"Loberia"},
{pais_id:1,	provincia_id:2,	nombre:"Lobos"},
{pais_id:1,	provincia_id:2,	nombre:"Los Cardales"},
{pais_id:1,	provincia_id:2,	nombre:"Los Toldos"},
{pais_id:1,	provincia_id:2,	nombre:"Lucila del Mar"},
{pais_id:1,	provincia_id:2,	nombre:"Luján"},
{pais_id:1,	provincia_id:2,	nombre:"Magdalena"},
{pais_id:1,	provincia_id:2,	nombre:"Maipú"},
{pais_id:1,	provincia_id:2,	nombre:"Mar Chiquita"},
{pais_id:1,	provincia_id:2,	nombre:"Mar de Ajó"},
{pais_id:1,	provincia_id:2,	nombre:"Mar de las Pampas"},
{pais_id:1,	provincia_id:2,	nombre:"Mar del Plata"},
{pais_id:1,	provincia_id:2,	nombre:"Mar del Tuyú"},
{pais_id:1,	provincia_id:2,	nombre:"Marcos Paz"},
{pais_id:1,	provincia_id:2,	nombre:"Mercedes"},
{pais_id:1,	provincia_id:2,	nombre:"Miramar"},
{pais_id:1,	provincia_id:2,	nombre:"Monte"},
{pais_id:1,	provincia_id:2,	nombre:"Monte Hermoso"},
{pais_id:1,	provincia_id:2,	nombre:"Munro"},
{pais_id:1,	provincia_id:2,	nombre:"Navarro"},
{pais_id:1,	provincia_id:2,	nombre:"Necochea"},
{pais_id:1,	provincia_id:2,	nombre:"Olavarría"},
{pais_id:1,	provincia_id:2,	nombre:"Partido de la Costa"},
{pais_id:1,	provincia_id:2,	nombre:"Pehuajó"},
{pais_id:1,	provincia_id:2,	nombre:"Pellegrini"},
{pais_id:1,	provincia_id:2,	nombre:"Pergamino"},
{pais_id:1,	provincia_id:2,	nombre:"Pigüé"},
{pais_id:1,	provincia_id:2,	nombre:"Pila"},
{pais_id:1,	provincia_id:2,	nombre:"Pilar"},
{pais_id:1,	provincia_id:2,	nombre:"Pinamar"},
{pais_id:1,	provincia_id:2,	nombre:"Pinar del Sol"},
{pais_id:1,	provincia_id:2,	nombre:"Polvorines"},
{pais_id:1,	provincia_id:2,	nombre:"Pte. Perón"},
{pais_id:1,	provincia_id:2,	nombre:"Puán"},
{pais_id:1,	provincia_id:2,	nombre:"Punta Indio"},
{pais_id:1,	provincia_id:2,	nombre:"Ramallo"},
{pais_id:1,	provincia_id:2,	nombre:"Rauch"},
{pais_id:1,	provincia_id:2,	nombre:"Rivadavia"},
{pais_id:1,	provincia_id:2,	nombre:"Rojas"},
{pais_id:1,	provincia_id:2,	nombre:"Roque Pérez"},
{pais_id:1,	provincia_id:2,	nombre:"Saavedra"},
{pais_id:1,	provincia_id:2,	nombre:"Saladillo"},
{pais_id:1,	provincia_id:2,	nombre:"Salliqueló"},
{pais_id:1,	provincia_id:2,	nombre:"Salto"},
{pais_id:1,	provincia_id:2,	nombre:"San Andrés de Giles"},
{pais_id:1,	provincia_id:2,	nombre:"San Antonio de Areco"},
{pais_id:1,	provincia_id:2,	nombre:"San Antonio de Padua"},
{pais_id:1,	provincia_id:2,	nombre:"San Bernardo"},
{pais_id:1,	provincia_id:2,	nombre:"San Cayetano"},
{pais_id:1,	provincia_id:2,	nombre:"San Clemente del Tuyú"},
{pais_id:1,	provincia_id:2,	nombre:"San Nicolás"},
{pais_id:1,	provincia_id:2,	nombre:"San Pedro"},
{pais_id:1,	provincia_id:2,	nombre:"San Vicente"},
{pais_id:1,	provincia_id:2,	nombre:"Santa Teresita"},
{pais_id:1,	provincia_id:2,	nombre:"Suipacha"},
{pais_id:1,	provincia_id:2,	nombre:"Tandil"},
{pais_id:1,	provincia_id:2,	nombre:"Tapalqué"},
{pais_id:1,	provincia_id:2,	nombre:"Tordillo"},
{pais_id:1,	provincia_id:2,	nombre:"Tornquist"},
{pais_id:1,	provincia_id:2,	nombre:"Trenque Lauquen"},
{pais_id:1,	provincia_id:2,	nombre:"Tres Lomas"},
{pais_id:1,	provincia_id:2,	nombre:"Villa Gesell"},
{pais_id:1,	provincia_id:2,	nombre:"Villarino"},
{pais_id:1,	provincia_id:2,	nombre:"Zárate"},
{pais_id:1,	provincia_id:1,	nombre:"Agronomía"},
{pais_id:1,	provincia_id:1,	nombre:"Almagro"},
{pais_id:1,	provincia_id:1,	nombre:"Balvanera"},
{pais_id:1,	provincia_id:1,	nombre:"Barracas"},
{pais_id:1,	provincia_id:1,	nombre:"Belgrano"},
{pais_id:1,	provincia_id:1,	nombre:"Boca"},
{pais_id:1,	provincia_id:1,	nombre:"Boedo"},
{pais_id:1,	provincia_id:1,	nombre:"Caballito"},
{pais_id:1,	provincia_id:1,	nombre:"Chacarita"},
{pais_id:1,	provincia_id:1,	nombre:"Coghlan"},
{pais_id:1,	provincia_id:1,	nombre:"Colegiales"},
{pais_id:1,	provincia_id:1,	nombre:"Constitución"},
{pais_id:1,	provincia_id:1,	nombre:"Flores"},
{pais_id:1,	provincia_id:1,	nombre:"Floresta"},
{pais_id:1,	provincia_id:1,	nombre:"La Paternal"},
{pais_id:1,	provincia_id:1,	nombre:"Liniers"},
{pais_id:1,	provincia_id:1,	nombre:"Mataderos"},
{pais_id:1,	provincia_id:1,	nombre:"Monserrat"},
{pais_id:1,	provincia_id:1,	nombre:"Monte Castro"},
{pais_id:1,	provincia_id:1,	nombre:"Nueva Pompeya"},
{pais_id:1,	provincia_id:1,	nombre:"Núñez"},
{pais_id:1,	provincia_id:1,	nombre:"Palermo"},
{pais_id:1,	provincia_id:1,	nombre:"Parque Avellaneda"},
{pais_id:1,	provincia_id:1,	nombre:"Parque Chacabuco"},
{pais_id:1,	provincia_id:1,	nombre:"Parque Chas"},
{pais_id:1,	provincia_id:1,	nombre:"Parque Patricios"},
{pais_id:1,	provincia_id:1,	nombre:"Puerto Madero"},
{pais_id:1,	provincia_id:1,	nombre:"Recoleta"},
{pais_id:1,	provincia_id:1,	nombre:"Retiro"},
{pais_id:1,	provincia_id:1,	nombre:"Saavedra"},
{pais_id:1,	provincia_id:1,	nombre:"San Cristóbal"},
{pais_id:1,	provincia_id:1,	nombre:"San Nicolás"},
{pais_id:1,	provincia_id:1,	nombre:"San Telmo"},
{pais_id:1,	provincia_id:1,	nombre:"Vélez Sársfield"},
{pais_id:1,	provincia_id:1,	nombre:"Versalles"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Crespo"},
{pais_id:1,	provincia_id:1,	nombre:"Villa del Parque"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Devoto"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Gral. Mitre"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Lugano"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Luro"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Ortúzar"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Pueyrredón"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Real"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Riachuelo"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Santa Rita"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Soldati"},
{pais_id:1,	provincia_id:1,	nombre:"Villa Urquiza"}
	])




