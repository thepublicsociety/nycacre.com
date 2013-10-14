class SendMail < ActionMailer::Base
  default :from => "nycacre.info@gmail.com"
  
  def email(sender, email, subject, message)
  	@message = message
  	@sender = sender
  	mail :to => email, :subject => subject
  end
  
  def notification
  	@message = "There are resources to approve at the following link: http://www.nycacre.com/administration/unapproved-resources"
  	mail :to => "nycacre@gmail.com", :subject => "There are resources to approve"
  end
  
end
