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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131007213247) do

  create_table "abouts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "subtitle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
    t.string   "about_image_file_name"
    t.string   "about_image_content_type"
    t.integer  "about_image_file_size"
    t.datetime "about_image_updated_at"
  end

  create_table "acres", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "content"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "acre_image_file_name"
    t.string   "acre_image_content_type"
    t.integer  "acre_image_file_size"
    t.datetime "acre_image_updated_at"
  end

  create_table "advisors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "advisor_photo_file_name"
    t.string   "advisor_photo_content_type"
    t.integer  "advisor_photo_file_size"
    t.datetime "advisor_photo_updated_at"
  end

  create_table "alerts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "publish",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "announcements", :force => true do |t|
    t.string   "headline"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "announcement_image_file_name"
    t.string   "announcement_image_content_type"
    t.integer  "announcement_image_file_size"
    t.datetime "announcement_image_updated_at"
    t.boolean  "displayed",                       :default => true
    t.integer  "tenant_id"
    t.integer  "post_id"
  end

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "question_id"
    t.integer  "votes"
    t.boolean  "accepted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.string   "tag"
    t.string   "category"
    t.boolean  "publish",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.string   "tenant"
    t.datetime "published_date"
    t.string   "website"
  end

  create_table "backgrounds", :force => true do |t|
    t.string   "page_controller"
    t.string   "page_action"
    t.string   "page_url"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "width"
    t.string   "height"
  end

  create_table "calendar_events", :force => true do |t|
    t.datetime "event_start"
    t.datetime "event_end"
    t.text     "description"
    t.string   "name"
    t.string   "location"
    t.string   "origin"
    t.integer  "origin_id"
    t.string   "google_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "phone"
    t.string   "website"
    t.string   "calendar_event_image_file_name"
    t.string   "calendar_event_image_content_type"
    t.integer  "calendar_event_image_file_size"
    t.datetime "calendar_event_image_updated_at"
  end

  create_table "challenge_stats", :force => true do |t|
    t.integer  "challenge_id"
    t.string   "name"
    t.string   "value"
    t.text     "description"
    t.boolean  "publish"
    t.boolean  "is_dollar_value", :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "challenges", :force => true do |t|
    t.string   "name"
    t.string   "content_title"
    t.text     "content"
    t.string   "subcontent_title"
    t.text     "subcontent"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "challenge_image_file_name"
    t.string   "challenge_image_content_type"
    t.integer  "challenge_image_file_size"
    t.datetime "challenge_image_updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies_sectors", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "sector_id"
  end

  create_table "companies_users", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "user_id"
  end

  create_table "contact_specialty_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.text     "description"
    t.string   "specialty"
    t.string   "author"
    t.text     "content"
    t.string   "tag"
    t.string   "category"
    t.string   "sector"
    t.string   "tenant"
    t.boolean  "publish",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "website"
    t.string   "telephone"
  end

  create_table "events", :force => true do |t|
    t.datetime "eventdate"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_image_file_name"
    t.string   "event_image_content_type"
    t.integer  "event_image_file_size"
    t.datetime "event_image_updated_at"
    t.datetime "eventenddate"
    t.string   "address_line_one"
    t.string   "address_line_two"
    t.string   "phone"
    t.string   "website"
  end

  create_table "facebook_users", :force => true do |t|
    t.string   "token"
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "link"
    t.string   "expires_at"
  end

  create_table "feed_entries", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "published_date"
    t.string   "category"
    t.string   "author"
    t.integer  "user_id"
    t.string   "entry_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "origin"
  end

  create_table "funding_status_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "graduates", :force => true do |t|
    t.string   "name"
    t.string   "content_title"
    t.text     "content"
    t.string   "subcontent_title"
    t.text     "subcontent"
    t.text     "description"
    t.string   "sector"
    t.boolean  "publish"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "graduate_image_file_name"
    t.string   "graduate_image_content_type"
    t.integer  "graduate_image_file_size"
    t.datetime "graduate_image_updated_at"
    t.string   "graduate_secondary_image_file_name"
    t.string   "graduate_secondary_image_content_type"
    t.integer  "graduate_secondary_image_file_size"
    t.datetime "graduate_secondary_image_updated_at"
    t.string   "email"
    t.string   "website"
  end

  create_table "grants", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "specialty"
    t.string   "author"
    t.text     "content"
    t.string   "tag"
    t.string   "category"
    t.string   "sector"
    t.string   "tenant"
    t.boolean  "publish",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "due_date"
    t.string   "website"
    t.string   "email"
    t.string   "telephone"
  end

  create_table "job_postings", :force => true do |t|
    t.string   "position"
    t.text     "description"
    t.string   "salary"
    t.datetime "available"
    t.boolean  "publish"
    t.integer  "tenant_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "memos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news_photos", :force => true do |t|
    t.string   "caption"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "article_id"
    t.integer  "tenant_id"
    t.integer  "graduate_id"
  end

  create_table "news_site_specialty_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news_sites", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "specialty"
    t.string   "author"
    t.text     "content"
    t.string   "tag"
    t.string   "category"
    t.string   "sector"
    t.string   "tenant"
    t.boolean  "publish",     :default => false
    t.string   "website"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "email"
    t.string   "telephone"
  end

  create_table "news_sources", :force => true do |t|
    t.string   "website"
    t.string   "name"
    t.string   "feed_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.text     "content"
    t.string   "tag"
    t.string   "category"
    t.boolean  "publish"
    t.boolean  "archive"
    t.boolean  "featured"
    t.string   "sector"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "subheading"
    t.string   "tenant"
    t.datetime "published_date"
    t.boolean  "internal_only",  :default => false
  end

  create_table "provider_specialty_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "specialty"
    t.string   "author"
    t.text     "content"
    t.string   "tag"
    t.string   "category"
    t.string   "sector"
    t.string   "tenant"
    t.boolean  "publish",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "website"
    t.string   "email"
    t.string   "telephone"
  end

  create_table "questions", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "answered",   :default => false
    t.integer  "votes"
    t.boolean  "closed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_specialty_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resumes", :force => true do |t|
    t.string   "name"
    t.string   "specialty"
    t.text     "cover_letter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resume_document_file_name"
    t.string   "resume_document_content_type"
    t.integer  "resume_document_file_size"
    t.datetime "resume_document_updated_at"
    t.boolean  "publish",                      :default => false
    t.string   "website"
    t.string   "email"
    t.string   "telephone"
  end

  create_table "resumes_tenants", :id => false, :force => true do |t|
    t.integer "resume_id"
    t.integer "tenant_id"
  end

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snippets", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subcontent_title"
    t.text     "subcontent"
    t.string   "snippet_image_file_name"
    t.string   "snippet_image_content_type"
    t.integer  "snippet_image_file_size"
    t.datetime "snippet_image_updated_at"
  end

  create_table "statements", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "publish",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "thing"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenant_applications", :force => true do |t|
    t.string   "company_name"
    t.string   "company_technology"
    t.string   "funding_status"
    t.string   "inception"
    t.text     "value_proposition"
    t.text     "current_structure"
    t.text     "ownership"
    t.text     "description"
    t.text     "revenue_model"
    t.text     "benefits"
    t.text     "evolution_status"
    t.text     "competitors"
    t.text     "competition_edge"
    t.text     "sustainability"
    t.text     "intellectual_property"
    t.text     "target_market"
    t.text     "entry_barriers"
    t.text     "customers"
    t.string   "name_and_title"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cash_flow_statement_file_name"
    t.string   "cash_flow_statement_content_type"
    t.integer  "cash_flow_statement_file_size"
    t.datetime "cash_flow_statement_updated_at"
    t.string   "current_structure_file_file_name"
    t.string   "current_structure_file_content_type"
    t.integer  "current_structure_file_file_size"
    t.datetime "current_structure_file_updated_at"
  end

  create_table "tenant_backgrounds", :force => true do |t|
    t.string   "page_controller"
    t.string   "page_action"
    t.string   "page_url"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "tenant_background_image_file_name"
    t.string   "tenant_background_image_content_type"
    t.integer  "tenant_background_image_file_size"
    t.datetime "tenant_background_image_updated_at"
    t.integer  "user_id"
    t.string   "width"
    t.string   "height"
  end

  create_table "tenant_stats", :force => true do |t|
    t.integer  "tenant_id"
    t.string   "name"
    t.string   "value"
    t.text     "description"
    t.boolean  "publish"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_dollar_value", :default => false
  end

  create_table "tenants", :force => true do |t|
    t.string   "name"
    t.string   "content_title"
    t.text     "content"
    t.string   "subcontent_title"
    t.text     "subcontent"
    t.text     "description"
    t.string   "sector"
    t.boolean  "publish"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tenant_image_file_name"
    t.string   "tenant_image_content_type"
    t.integer  "tenant_image_file_size"
    t.datetime "tenant_image_updated_at"
    t.string   "tenant_secondary_image_file_name"
    t.string   "tenant_secondary_image_content_type"
    t.integer  "tenant_secondary_image_file_size"
    t.datetime "tenant_secondary_image_updated_at"
    t.string   "email"
    t.boolean  "active",                              :default => true
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "website"
    t.text     "resume_prefs"
  end

  create_table "tool_specialty_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tools", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "specialty"
    t.text     "description"
    t.string   "category"
    t.string   "tag"
    t.boolean  "publish",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "user_events", :force => true do |t|
    t.string   "origin"
    t.datetime "event_start"
    t.datetime "event_end"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.text     "content"
    t.string   "location"
    t.string   "map"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "origin_id"
    t.string   "google_id"
    t.string   "phone"
    t.string   "website"
    t.string   "user_event_image_file_name"
    t.string   "user_event_image_content_type"
    t.integer  "user_event_image_file_size"
    t.datetime "user_event_image_updated_at"
    t.string   "google_link"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
    t.string   "name"
    t.string   "role"
    t.boolean  "checkedin",                             :default => false
    t.boolean  "restroom",                              :default => false
    t.integer  "tenant_id"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.datetime "last_request_at"
    t.boolean  "super_admin"
    t.string   "google_oauth"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.string   "selected_calendar"
    t.string   "fb_token"
    t.string   "fb_expires_at"
    t.datetime "invitation_created_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
