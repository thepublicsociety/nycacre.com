# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  answered   :boolean          default(FALSE)
#  votes      :integer
#  closed     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user, :foreign_key => "user_id"
end
