# == Schema Information
#
# Table name: events
#
#  id                       :integer          not null, primary key
#  eventdate                :datetime
#  title                    :string(255)
#  content                  :text
#  created_at               :datetime
#  updated_at               :datetime
#  event_image_file_name    :string(255)
#  event_image_content_type :string(255)
#  event_image_file_size    :integer
#  event_image_updated_at   :datetime
#  eventenddate             :datetime
#

class Event < ActiveRecord::Base
  has_attached_file :event_image, :styles => {:thumb => "250x250>", :main => "631x298>"}, :default_url => "/assets/empty.png"
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "event", item_id).empty?
  end
  
  def start_time
    eventdate
  end
  def event_start
    eventdate
  end
  def event_end
    eventenddate
  end
end
