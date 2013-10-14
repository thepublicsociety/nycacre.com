class NewsSite < ActiveRecord::Base
  attr_accessible :author, :category, :content, :description, :name, :publish, :sector, :specialty, :tag, :tenant, :website, :email, :telephone
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "news_site", item_id).empty?
  end
end
