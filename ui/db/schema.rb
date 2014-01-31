# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140131100311) do

  create_table "builds", force: true do |t|
    t.string   "state",             default: "scheduled"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "distribution_name"
    t.boolean  "locked",            default: false
    t.text     "comment"
    t.boolean  "released",          default: false
  end

  add_index "builds", ["project_id"], name: "index_builds_on_project_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "logs", force: true do |t|
    t.text     "chunk"
    t.integer  "build_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
  end

  add_index "logs", ["build_id"], name: "index_logs_on_build_id"

# Could not dump table "projects" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "settings", force: true do |t|
    t.text     "perl5lib"
    t.text     "skip_missing_prerequisites"
    t.text     "pinto_downsteram_repositories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "force_mode",                    default: false
  end

  create_table "sources", force: true do |t|
    t.string   "url"
    t.text     "scm_type"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sn",         default: 0
    t.boolean  "state",      default: true
    t.string   "last_rev"
  end

  add_index "sources", ["project_id"], name: "index_sources_on_project_id"

end
