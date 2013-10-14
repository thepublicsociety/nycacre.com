class Memo < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :notes, :user_id
  belongs_to :user
end
