class Tool < ActiveRecord::Base
  #attr_accessible :category, :description, :name, :publish, :specialty, :tag, :website
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "tool", item_id).empty?
  end
end
