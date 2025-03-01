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

ActiveRecord::Schema[8.0].define(version: 2025_03_01_030441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "section"
    t.string "year"
    t.string "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "peer_teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "uin"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pt_enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "peer_teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_pt_enrollments_on_course_id"
    t.index ["peer_teacher_id"], name: "index_pt_enrollments_on_peer_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "uin"
    t.string "major"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "pt_enrollments", "courses"
  add_foreign_key "pt_enrollments", "peer_teachers"
end
