class AlertMailer < ActionMailer::Base
  default :from => "alerts@stormsavvy.com"

  def pop
    @greeting = "Storm Savvy Weather Alert"
    mail(
      :to => "#{user.login} <#{user.email}>",
      :subject => "Storm Savv Weather Alert" 
      )
  end
end
