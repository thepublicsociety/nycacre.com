# == Schema Information
#
# Table name: resumes
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  specialty                    :string(255)
#  cover_letter                 :text
#  created_at                   :datetime
#  updated_at                   :datetime
#  resume_document_file_name    :string(255)
#  resume_document_content_type :string(255)
#  resume_document_file_size    :integer
#  resume_document_updated_at   :datetime
#

class Resume < ActiveRecord::Base
  has_attached_file :resume_document
  validates_presence_of :resume_document
  validates_format_of :resume_document_file_name, :with => %r{\.(pdf)$}i
  
  def saved?(user)
    item_id = self.id
    user_id = user.id
    return !User.find(user_id).memos.where("item_type=? and item_id=?", "resume", item_id).empty?
  end
end
