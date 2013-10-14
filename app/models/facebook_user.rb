class FacebookUser < ActiveRecord::Base
  attr_accessible :name, :token, :uid, :link, :expires_at
end
