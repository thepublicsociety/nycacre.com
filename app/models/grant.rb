class Grant < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "grant", item_id).empty?
  end
  
  def start_time
    due_date
  end
end
