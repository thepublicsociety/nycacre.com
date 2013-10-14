# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  votes       :integer
#  accepted    :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Answer < ActiveRecord::Base
  belongs_to :question, :foreign_key => "question_id"
  belongs_to :user, :foreign_key => "user_id"
end
