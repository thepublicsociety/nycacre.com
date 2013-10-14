class NewsSource < ActiveRecord::Base
  attr_accessible :feed_url, :name, :website, :user_id
  belongs_to :user
end
