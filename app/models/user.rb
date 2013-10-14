# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  name                   :string(255)
#  role                   :string(255)
#  checkedin              :boolean          default(FALSE)
#  restroom               :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :name, :role, :tenant_id,
                  :google_oauth, :refresh_token, :expires_at, :selected_calendar, :fb_token, :fb_expires_at, :invitation_created_at
  has_and_belongs_to_many :companies
  belongs_to :tenant
  has_many :questions
  has_many :answers
  has_many :memos
  has_many :user_events
  has_many :news_sources
  has_many :tenant_backgrounds
  has_many :feed_entries
end
