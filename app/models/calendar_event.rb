class CalendarEvent < ActiveRecord::Base
  attr_accessible :description, :event_end, :event_start, :google_id, :location, :name, :origin, :origin_id, :phone, :website, :calendar_event_image
  has_attached_file :calendar_event_image, :styles => {:thumb => "250x250>", :main => "631x298>"}, :default_url => "/assets/empty.png"
  def start_time
    event_start
  end
  def title
    name
  end
  def eventdate
    event_start
  end
  def eventenddate
    event_end
  end
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "calendar_event", item_id).empty?
  end
end
