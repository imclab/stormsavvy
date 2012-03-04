class UserMailer < ActionMailer::Base
  default :from => "alerts@stormsavvy.com"

  def pop_alert(user)
    mail(:to => user.email, :subject => "Daily weather alerts")
  end
end
