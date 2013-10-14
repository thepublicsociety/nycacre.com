# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  author     :string(255)
#  tag        :string(255)
#  category   :string(255)
#  publish    :boolean
#  created_at :datetime
#  updated_at :datetime
#  subtitle   :string(255)
#

class Article < ActiveRecord::Base
  has_many :news_photos, :dependent => :destroy
  accepts_nested_attributes_for :news_photos, :allow_destroy => true
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "article", item_id).empty?
  end
end
