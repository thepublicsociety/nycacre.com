class SendMail < ActionMailer::Base
  default :from => "nycacre.info@gmail.com"
  
  def email(sender, email, subject, message)
  	@message = message
  	@sender = sender
  	mail :to => email, :subject => subject
  end
  
  def notification
  	@message = "There are resources to approve at the following link: http://nycacre.com/administration/unapproved-resources"
  	mail :to => "ewheeler@poly.edu", :subject => "There are resources to approve"
  end
  
  def appnotification
  	@message = "A tenant application has been received. Review it through the following link: http://nycacre.com/administration/applicants"
  	mail :to => "ewheeler@poly.edu", :subject => "New Tenant Application"
  end
  
  def resnotification(resume, email)
    @message = "#{resume.name || "Someone"} has submitted a resume to your company. The direct link to it is: http://nycacre.com#{resume.resume_document.url}."
    mail :to => email, :cc => "ewheeler@poly.edu", :subject => "New Resume Submission"
  end
  
end
