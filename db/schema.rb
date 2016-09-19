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

ActiveRecord::Schema.define(version: 20160919195412) do

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

  create_table "familia", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
  end

  create_table "models", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "monedas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "simbolo"
    t.float    "tipoDeCambio"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "numeradors", force: :cascade do |t|
    t.string   "comprobante"
    t.integer  "puntoDeVenta"
    t.integer  "numero"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "distribuidor_id"
    t.integer  "pendiente_remitir"
    t.string   "estado"
  end

  create_table "producto_historicos", force: :cascade do |t|
    t.integer  "producto_id"
    t.float    "precio"
    t.datetime "fechaDesde"
    t.datetime "fechaHasta"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "remitos", force: :cascade do |t|
    t.integer  "pedido_id"
    t.string   "numero"
    t.datetime "fecha"
    t.string   "transporte"
    t.float    "ivaTotal"
    t.float    "total"
    t.integer  "cantidadTotal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.string   "email",                  default: "", null: false
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "password_digest"
    t.string   "razonSocial"
    t.string   "direccion"
    t.integer  "localidad_id"
    t.string   "cuig"
    t.string   "renspa"
    t.float    "cuit"
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
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
