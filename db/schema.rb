# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_13_010013) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "proyecto_tecnologia", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "tecnologia_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_proyecto_tecnologia_on_proyecto_id"
    t.index ["tecnologia_id"], name: "index_proyecto_tecnologia_on_tecnologia_id"
  end

  create_table "proyecto_usuarios", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_proyecto_usuarios_on_proyecto_id"
    t.index ["usuario_id"], name: "index_proyecto_usuarios_on_usuario_id"
  end

  create_table "proyectos", force: :cascade do |t|
    t.string "nombre"
    t.date "fecha_inicio"
    t.date "fecha_fin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tecnologia", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "proyecto_tecnologia", "proyectos"
  add_foreign_key "proyecto_tecnologia", "tecnologia", column: "tecnologia_id"
  add_foreign_key "proyecto_usuarios", "proyectos"
  add_foreign_key "proyecto_usuarios", "usuarios"
end
