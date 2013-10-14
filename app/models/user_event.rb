class UserEvent < ActiveRecord::Base
  attr_accessible :content, :description, :event_end, :event_start, :location, :map, :name, :origin, :url, :user_id, :origin_id, :google_id, :phone, :website, :user_event_image, :google_link
  has_attached_file :user_event_image, :styles => {:thumb => "250x250>", :main => "631x298>"}, :default_url => "/assets/empty.png"
  belongs_to :user
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "userevent", item_id).empty?
  end
  
  def start_time
    event_start
  end
end
