# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170418182655) do

  create_table "bancos", force: :cascade do |t|
    t.integer  "codigo"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cheques", force: :cascade do |t|
    t.integer  "pago_id"
    t.float    "monto"
    t.integer  "estado"
    t.string   "numero"
    t.date     "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "recibido"
    t.boolean  "confirmado"
    t.boolean  "rechazado"
    t.integer  "banco"
  end

  create_table "ciudades", force: :cascade do |t|
    t.integer  "pais_id"
    t.integer  "provincia_id"
    t.string   "nombre"
    t.string   "nombre_corto"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "condicion_pagos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "dias"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cuenta_corrientes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "concepto"
    t.string   "conceptoNumero"
    t.float    "monto"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "detalle_insumos", force: :cascade do |t|
    t.integer  "pedido_id"
    t.integer  "producto_id"
    t.integer  "insumo_id"
    t.integer  "cantidad_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "detalle_id"
  end

  create_table "detalles", force: :cascade do |t|
    t.integer  "pedido_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "rango_desde"
    t.string   "rango_hasta"
    t.integer  "pendiente_remitir"
  end

  create_table "factura_items", force: :cascade do |t|
    t.integer  "factura_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.float    "neto"
    t.float    "iva"
    t.float    "subtotal"
    t.integer  "descuento"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "remito_id"
  end

  create_table "facturas", force: :cascade do |t|
    t.integer  "cuit",            limit: 8
    t.datetime "fecha"
    t.string   "control"
    t.string   "vendedor"
    t.float    "subtotal"
    t.float    "bonificacion"
    t.float    "neto"
    t.float    "iva"
    t.float    "iibb"
    t.float    "total"
    t.string   "cae"
    t.string   "vencimiento_cae"
    t.integer  "pto_venta"
    t.integer  "numero"
    t.string   "tipo"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "estado"
    t.string   "observaciones"
  end

  create_table "facturas_remitos", id: false, force: :cascade do |t|
    t.integer "remito_id",  null: false
    t.integer "factura_id", null: false
    t.index ["factura_id", "remito_id"], name: "index_facturas_remitos_on_factura_id_and_remito_id"
    t.index ["remito_id", "factura_id"], name: "index_facturas_remitos_on_remito_id_and_factura_id"
  end

  create_table "familia", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "insumo_historicos", force: :cascade do |t|
    t.integer  "insumo_id"
    t.integer  "precio"
    t.datetime "fechaDesde"
    t.datetime "fechaHasta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insumos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.float    "precio"
    t.integer  "unidad_medida"
    t.integer  "stock_fisico"
    t.integer  "stock_reservado"
    t.integer  "stock_disponible"
    t.integer  "stock_pedido"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "alerta"
    t.string   "imagen"
  end

  create_table "medidas", force: :cascade do |t|
    t.integer  "codigoAfip"
    t.string   "nombre"
    t.string   "abreviatura"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mensajes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "empresa"
    t.string   "email"
    t.string   "telefono"
    t.string   "texto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "leido"
  end

  create_table "nota_credito_items", force: :cascade do |t|
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.float    "neto"
    t.float    "iva"
    t.float    "subtotal"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "nota_credito_id"
  end

  create_table "nota_creditos", force: :cascade do |t|
    t.integer  "cliente_id"
    t.integer  "factura_id"
    t.integer  "distribuidor_id"
    t.integer  "vendedor_id"
    t.datetime "fecha"
    t.integer  "estado"
    t.integer  "tipo"
    t.float    "neto"
    t.float    "iva"
    t.float    "total"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "numero"
  end

  create_table "numeradors", force: :cascade do |t|
    t.string   "comprobante"
    t.integer  "puntoDeVenta"
    t.integer  "numero"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pagina_principal_productos", force: :cascade do |t|
    t.string   "imagen"
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "pagina_principal_id"
  end

  create_table "pagina_principals", force: :cascade do |t|
    t.string   "imagen_principal"
    t.string   "nosotros_texto"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "pagos", force: :cascade do |t|
    t.integer  "distribuidor_id"
    t.integer  "numero"
    t.string   "medioDePago"
    t.float    "monto"
    t.integer  "estado"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "paises", force: :cascade do |t|
    t.string   "nombre"
    t.string   "abreviacion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pedido_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "pedido_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "cantidadTotal"
    t.integer  "tipo"
    t.string   "titular"
    t.string   "cuit"
    t.float    "precioTotal"
    t.boolean  "remitido"
    t.boolean  "facturado"
    t.integer  "comprobanteNumero"
    t.integer  "condicionCompra"
    t.integer  "sucursal"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "distribuidor_id"
    t.integer  "pendiente_remitir"
    t.string   "estado"
    t.integer  "status"
    t.boolean  "pendiente_confirmar"
  end

  create_table "producto_historicos", force: :cascade do |t|
    t.integer  "producto_id"
    t.float    "precio"
    t.datetime "fechaDesde"
    t.datetime "fechaHasta"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "producto_insumos", force: :cascade do |t|
    t.integer  "producto_id"
    t.integer  "insumo_id"
    t.integer  "coeficiente"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "por_defecto"
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.float    "precio"
    t.boolean  "activo"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "familia_id"
    t.integer  "familium_id"
    t.integer  "stock_fisico"
    t.integer  "stock_disponible"
    t.integer  "stock_reservado"
    t.integer  "stock_pedido"
    t.string   "imagen"
    t.boolean  "rango"
    t.integer  "tipo"
    t.boolean  "correlativo"
    t.index ["familia_id"], name: "index_productos_on_familia_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "provincias", force: :cascade do |t|
    t.integer  "pais_id"
    t.string   "nombre"
    t.string   "nombre_corto"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "codigoAfip"
  end

  create_table "rangos", force: :cascade do |t|
    t.string   "letras"
    t.string   "numero"
    t.integer  "digito"
    t.integer  "pedido_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relacions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cliente_id"
  end

  create_table "remito_items", force: :cascade do |t|
    t.integer  "remito_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.float    "subtotal"
    t.float    "iva"
    t.float    "precioNeto"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "facturado"
    t.integer  "pendiente_facturar"
  end

  create_table "remitos", force: :cascade do |t|
    t.integer  "pedido_id"
    t.integer  "numero"
    t.datetime "fecha"
    t.string   "transporte"
    t.float    "ivaTotal"
    t.float    "total"
    t.integer  "cantidadTotal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "finalizado"
    t.string   "empresa"
    t.integer  "dniRetira"
    t.string   "telefono"
    t.string   "numeroGuia"
    t.string   "destino"
    t.string   "retira"
    t.string   "comentarios"
    t.boolean  "facturado"
    t.string   "estado"
  end

  create_table "stock_items", force: :cascade do |t|
    t.integer  "producto_id"
    t.integer  "stock_pedido_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.float    "subtotal"
    t.boolean  "recibido"
    t.float    "cantidadRecibida"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "insumo_id"
  end

  create_table "stock_pedidos", force: :cascade do |t|
    t.string   "vendedor"
    t.integer  "cantidadTotal"
    t.float    "precioTotal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "transportista", force: :cascade do |t|
    t.string   "nombre"
    t.string   "dni"
    t.string   "cuit"
    t.string   "destino"
    t.string   "numeroGuia"
    t.float    "dniRetira"
    t.string   "comentarios"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_rangos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "producto_id"
    t.integer  "rango"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_sucursals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nombre"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "encargado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "password_digest"
    t.string   "razonSocial"
    t.string   "direccion"
    t.integer  "localidad_id"
    t.string   "cuig"
    t.string   "renspa"
    t.integer  "cuit",                   limit: 8
    t.string   "telefono"
    t.string   "codigoPostal"
    t.integer  "provincia_id"
    t.integer  "pais_id"
    t.string   "encargado"
    t.string   "celular"
    t.string   "numeroCv"
    t.integer  "profile_id"
    t.integer  "condicion_id"
    t.integer  "distribuidor_id"
    t.integer  "role"
    t.integer  "rango"
    t.integer  "descuento"
  end

end
