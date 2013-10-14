class Statement < ActiveRecord::Base
  attr_accessible :content, :publish, :title
end
